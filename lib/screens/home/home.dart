import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/widgets/feature_card.dart';
import 'package:tongnyampah/widgets/gift_card.dart';
import 'package:tongnyampah/models/Gift.dart';
import 'package:tongnyampah/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey bottomNavigationKey = GlobalKey();
  String name = '';
  int point = 0;
  File _image;

  Future _openCamera(BuildContext context, String type) async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      _image = picture;
    });

    if (_image != null) {
      Navigator.pushNamed(context, '/report', arguments: {
        "image": _image,
        "type": type,
      });
    }
  }

  void getUserData(user) {
    user.data.then((value) {
      setState(() {
        name = value["name"];
        point = value["point"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    getUserData(_user);

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Navbar(),
            Container(
              padding: EdgeInsets.fromLTRB(38.0, 36.0, 38.0, 0),
              child: Text(
                'Hi, ${name.split(" ").first}',
                style: TextStyle(
                  fontSize: 42.0,
                  fontFamily: 'Aeonik',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(38.0, 0, 38.0, 0),
              child: Text(
                '$point Point',
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'Aeonik',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(38.0, 40.0, 38.0, 0),
              child: Text(
                'Get Points !',
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'Aeonik',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15.0),
              height: 175.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  FeatureCard(
                    icon: Icons.camera,
                    title: 'Capture',
                    margin: EdgeInsets.only(left: 38.0),
                    onTap: () => _openCamera(context, 'capture'),
                  ),
                  FeatureCard(
                    icon: Icons.restore,
                    title: 'Recycle',
                    margin: EdgeInsets.only(left: 16.0),
                    onTap: () {
                      Navigator.pushNamed(context, '/report');
                    },
                  ),
                  FeatureCard(
                    icon: Icons.report,
                    title: 'Report',
                    margin: EdgeInsets.only(left: 16.0, right: 38.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(38.0, 25.0, 38.0, 0.0),
              child: Text(
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque odio odio, vehicula at mattis ac, commodo sed risus. Vivamus sollicitudin risus sed erat eleifend pulvinar. Aenean non nulla ac enim viverra sagittis non quis tortor. Sed lacinia metus vel lacus vestibulum, sed interdum metus cursus. Quisque tincidunt, nisl non rutrum blandit, tortor massa feugiat nulla, vulputate molestie ligula justo id mauris. Maecenas lacinia massa sem, ac volutpat nisi congue et. Mauris vel elit id sem viverra sagittis ut a mi. Morbi at leo at orci venenatis pretium. Vivamus id finibus ipsum.''',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(38.0, 35.0, 38.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Store',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontFamily: 'Aeonik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Text(
                        'See more',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Aeonik',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              height: 190.0,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                scrollDirection: Axis.horizontal,
                children: Gift.getAllGift()
                    .map((gift) => GiftCard(
                          margin: EdgeInsets.only(left: 20.0),
                          image: gift.image,
                          title: gift.name,
                          point: gift.point,
                        ))
                    .toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 38.0),
              padding: EdgeInsets.fromLTRB(38.0, 25.0, 38.0, 0.0),
              child: Text(
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque odio odio, vehicula at mattis ac, commodo sed risus. Vivamus sollicitudin risus sed erat eleifend pulvinar. Aenean non nulla ac enim viverra sagittis non quis tortor. Sed lacinia metus vel lacus vestibulum, sed interdum metus cursus. Quisque tincidunt, nisl non rutrum blandit, tortor massa feugiat nulla, vulputate molestie ligula justo id mauris. Maecenas lacinia massa sem, ac volutpat nisi congue et. Mauris vel elit id sem viverra sagittis ut a mi. Morbi at leo at orci venenatis pretium. Vivamus id finibus ipsum.''',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
