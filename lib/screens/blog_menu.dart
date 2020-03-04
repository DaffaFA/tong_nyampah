import 'package:flutter/material.dart';
import 'package:tongnyampah/widgets/navbar.dart';
import 'package:tongnyampah/widgets/news_card.dart';

class BlogMenu extends StatefulWidget {
  @override
  _BlogMenuState createState() => _BlogMenuState();
}

class _BlogMenuState extends State<BlogMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Navbar(isSearch: true),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Your daily read',
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  Column(
                    children: <Widget>[
                      NewsCard(),
                      NewsCard(),
                      NewsCard(),
                      NewsCard(),
                      NewsCard(),
                      NewsCard(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
