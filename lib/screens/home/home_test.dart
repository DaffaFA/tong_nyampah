import 'package:flutter/material.dart';
import 'package:tongnyampah/widgets/feature_card.dart';
import 'package:tongnyampah/widgets/gift_card.dart';

class HomeTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Builder(
                    builder: (context) => GestureDetector(
                      child: Icon(
                        Icons.menu,
                        size: 35.0,
                        color: Color(0xFF070707),
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  // GestureDetector(
                  //   child: Icon(
                  //     Icons.menu,
                  //     size: 35.0,
                  //     color: Color(0xFF070707),
                  //   ),
                  // ),
                  GestureDetector(
                    child: Icon(
                      Icons.notifications,
                      size: 35.0,
                      color: Color(0xFF070707),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(38.0, 36.0, 38.0, 0),
              child: Text(
                'Hi, Daffa',
                style: TextStyle(
                  fontSize: 42.0,
                  fontFamily: 'Aeonik',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(38.0, 0, 38.0, 0),
              child: Text(
                '10 Point',
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
                  ),
                  FeatureCard(
                    icon: Icons.restore,
                    title: 'Recycle',
                    margin: EdgeInsets.only(left: 16.0),
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
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 15.0,
              ),
              height: 175.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GiftCard(
                    margin: EdgeInsets.only(left: 38.0),
                  ),
                  GiftCard(
                    margin: EdgeInsets.only(left: 16.0),
                  ),
                  GiftCard(
                    margin: EdgeInsets.only(left: 16.0, right: 38.0)
                  ),
                ],
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
