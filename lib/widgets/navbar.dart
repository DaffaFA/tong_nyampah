import 'package:flutter/material.dart';
import 'package:tongnyampah/app.dart';

class Navbar extends StatelessWidget {
  @required final String condition;

  Navbar({this.condition});

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
          Builder(
            builder: (context) => GestureDetector(
              child: Icon(
                condition == null ? Icons.notifications
                    : condition == 'search' ? Icons.search : condition == 'shop' ? Icons.shopping_cart : Icons.notifications ,
                size: 35.0,
                color: Color(0xFF070707),
              ),
              onTap: () => condition == null ? Navigator.pushNamed(context, NotificationRoute) : Naviga,
            ),
          )
        ],
      ),
    );
  }
}
