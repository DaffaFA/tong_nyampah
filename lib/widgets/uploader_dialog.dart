import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:uuid/uuid.dart';

class UploaderDialog extends StatefulWidget {
  final String title, description;
  @required
  final String uid, type;
  @required
  final File image;

  UploaderDialog(
      {this.title, this.description, this.image, this.type, this.uid});

  @override
  _UploaderDialog createState() => _UploaderDialog();
}

class _UploaderDialog extends State<UploaderDialog> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://tong-nyampah.appspot.com/');

  StorageUploadTask _uploadTask;
  
  final String uuid = Uuid().v1();

  void _startUpload() {

    String filePath =
        '${widget.type[0].toUpperCase()}${widget.type.substring(1)}/${widget.type[0].toUpperCase()}${widget.type.substring(1)}-$uuid';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.image);
    });
  }

  Future<void> _sendReport() async {
    dynamic downloadUrl = await _storage.ref().child('${widget.type[0].toUpperCase()}${widget.type.substring(1)}/${widget.type[0].toUpperCase()}${widget.type.substring(1)}-$uuid').getDownloadURL();

    await DatabaseService(uid: widget.uid).createNewReport(
      title: widget.title,
      image: downloadUrl,
      type: widget.type,
      description: widget.description,
    );
  }

  @override
  void initState() {
    super.initState();
    _startUpload();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    Widget screen;
    if (_uploadTask != null) {
      screen = StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          if (_uploadTask.isComplete) {
            _sendReport();
          }

          return Container(
            padding: EdgeInsets.only(
              top: 28.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            margin: EdgeInsets.only(top: 45.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Uploading',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 14.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            '${(progressPercent * 100).toStringAsFixed(2)} %',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        LinearProgressIndicator(
                          value: progressPercent,
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    'Please wait while we uploading your report',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            _uploadTask.cancel();
                            Navigator.of(context).pop(); // To close the dialog
                            Navigator.of(context).pop(); // To close the dialog
                          },
                          child: Text('Close'),
                        ),
                      ),
                      _uploadTask.isComplete
                          ? Text(
                              '*Uploaded, feel free to close this dialog',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 8.5),
                            )
                          : _uploadTask.isInProgress
                              ? Container(
                                  child: FlatButton(
                                    onPressed: () {
                                      _uploadTask
                                          .pause(); // To close the dialog
                                    },
                                    child: Text('Pause'),
                                  ),
                                )
                              : _uploadTask.isPaused
                                  ? Container(
                                      child: FlatButton(
                                        onPressed: () {
                                          _uploadTask
                                              .resume(); // To close the dialog
                                        },
                                        child: Text('Pause'),
                                      ),
                                    )
                                  : Text(
                                      '*Uploaded, feel free to close this dialog',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 8.5),
                                    )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return screen;
  }
}
