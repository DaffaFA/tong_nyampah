import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String image;
  final int point;
  final String title;

  GiftCard({this.margin, this.image, this.point, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.0,
      margin: this.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        color: Colors.grey,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x22070707),
            offset: Offset(-0.5, 0.0),
            blurRadius: 8.0,
          )
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(this.image),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          constraints: BoxConstraints.expand(height: 60.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 0.0),
                child: Text(
                  this.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0.0),
                child: Text(
                  '$point Points',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
