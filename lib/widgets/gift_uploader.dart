import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:uuid/uuid.dart';

class GiftUploader extends StatefulWidget {
  final String title, description;
  final int point;
  @required
  final File image;

  GiftUploader({this.title, this.description, this.image, this.point});

  @override
  _GiftUploader createState() => _GiftUploader();
}

class _GiftUploader extends State<GiftUploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://tong-nyampah.appspot.com/');

  StorageUploadTask _uploadTask;

  final String uuid = Uuid().v1();

  void _startUpload() {
    String filePath = 'Gifts/$uuid';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.image);
    });
  }

  Future<void> _sendReport() async {
    dynamic downloadUrl =
        await _storage.ref().child('Gifts/$uuid').getDownloadURL();

    await DatabaseService().createNewGifts(
      title: widget.title,
      image: downloadUrl,
      point: widget.point,
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
            decoration: BoxDecoration(
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
                    'Please wait while we uploading your post',
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
                            _uploadTask.isComplete ?? _uploadTask.cancel();
                            Navigator.of(context).pop(); // To close the dialog
                            Navigator.of(context).pop(); // To close the dialog
                          },
                          child:
                              Text(_uploadTask.isComplete ? 'Close' : 'Cancel'),
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
