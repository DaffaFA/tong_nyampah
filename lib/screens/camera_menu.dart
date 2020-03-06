import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CameraMenu extends StatefulWidget {
  @override
  _CameraMenuState createState() => _CameraMenuState();
}

class _CameraMenuState extends State<CameraMenu> {
  File image;
  String imagePath;

  Future _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      image = picture;
      imagePath = basename(picture.path);
    });
  }

  Future<void> _optionsDialogBox(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                InkWell(
                  child: new Text('Take a picture'),
                  onTap: () async => this._openCamera,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: new Text('Select from gallery'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.camera),
        onPressed: () => this._optionsDialogBox(context),
      ),
    );
  }
}
