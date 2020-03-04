import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraMenu extends StatefulWidget {
  @override
  _CameraMenuState createState() => _CameraMenuState();
}

class _CameraMenuState extends State<CameraMenu> {
  @override
  void initState() {
    this._optionsDialogBox();
    super.initState();
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: () {},
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
        });
  }

  @override
  Widget build(BuildContext context) {}
}
