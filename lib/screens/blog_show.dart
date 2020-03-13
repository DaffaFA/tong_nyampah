import 'package:flutter/material.dart';

class BlogShow extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final String image;

  BlogShow({this.title, this.image, this.description, this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 28.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  title,
                  style: TextStyle(color: Color(0xFF070707), fontSize: 24.0),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '${timestamp.substring(0, 11)} • ${timestamp.substring(11, 19)}',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 26.0),
                height: 200.0,
                child: Image.network(image, fit: BoxFit.cover),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(description,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
