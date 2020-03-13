import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tongnyampah/widgets/gift_uploader.dart';

class AddGifts extends StatefulWidget {
  final File image;

  AddGifts(this.image);

  @override
  _AddGiftsState createState() => _AddGiftsState();
}

class _AddGiftsState extends State<AddGifts> {
  TextEditingController _titleController = TextEditingController();
  String _title = '';
  String _description = '';
  TextEditingController _descriptionController = TextEditingController();
  int _point = 0;
  TextEditingController _pointController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Add Gift')),
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
                key: _formKey,
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
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
                        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _point = int.parse(value);
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _pointController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Point',
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
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
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) => GiftUploader(
                                title: _title,
                                description: _description,
                                image: widget.image,
                                point: _point,
                              ),
                            );
                          }
                          return null;
                        },
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
            ],
          ),
        ),
      ),
    );
  }
}
