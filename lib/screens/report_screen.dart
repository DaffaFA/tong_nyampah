import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/widgets/uploader_dialog.dart';

class ReportScreen extends StatefulWidget {
  final String type;
  final File image;

  ReportScreen({this.type, this.image});

  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  TextEditingController _titleController = TextEditingController();
  String _title = '';
  String _description = '';
  TextEditingController _descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        height: MediaQuery.of(context).size.height * 0.185,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 7.0),
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              height: MediaQuery.of(context).size.width * 0.12,
              child: InkWell(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              height: MediaQuery.of(context).size.width * 0.12,
              child: InkWell(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      'DENY',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                height: !(widget.type == 'capture')
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height,
                child: Image.file(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              !(widget.type == 'capture')
                  ? Form(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _title = value;
                                  });
                                },
                                controller: _titleController,
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
                                onChanged: (value) {
                                  setState(() {
                                    _description = value;
                                  });
                                },
                                controller: _descriptionController,
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
                              onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    UploaderDialog(
                                  uid: _user.uid,
                                  title: _title,
                                  description: _description,
                                  type: widget.type,
                                  image: widget.image,
                                ),
                              ),
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
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
