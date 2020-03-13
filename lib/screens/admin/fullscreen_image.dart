import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String image;

  FullScreenImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 13.0, top: 12.0),
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.chevron_left,
                size: 60.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
