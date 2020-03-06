import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  final String type;
  final File image;

  ReportScreen({this.type, this.image});

  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://tong-nyampah.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath =
        '${widget.type[0].toUpperCase()}${widget.type.substring(1)}/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
              '${widget.type[0].toUpperCase()}${widget.type.substring(1)}')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.file(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Color(0xFF070707),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: Color(0xFF070707),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _startUpload(),
                        child: Container(
                          margin: EdgeInsets.only(top: 18.0),
                          height: 50.0,
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
