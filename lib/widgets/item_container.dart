import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final List<Widget> children;

  ItemContainer({this.margin, this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 38.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    'Baru ditambahkan',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            height: 175.0,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              scrollDirection: Axis.horizontal,
              children: this.children,
            ),
          )
        ],
      ),
    );
  }
}
