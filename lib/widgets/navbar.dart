import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final bool isSearch;

  Navbar({this.isSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              isSearch == null ? Icons.notifications : isSearch ? Icons.search : Icons.notifications,
              size: 35.0,
              color: Color(0xFF070707),
            ),
            onTap: () {
            },
          )
        ],
      ),
    );
  }
}
