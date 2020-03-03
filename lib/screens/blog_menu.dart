import 'package:flutter/material.dart';
import 'package:tongnyampah/widgets/navbar.dart';

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
            
          ],
        ),
      ),
    );
  }
}
