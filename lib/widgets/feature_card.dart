import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  @required
  final IconData icon;
  @required
  final String title;
  @required
  final EdgeInsetsGeometry margin;
  final Function onTap;

  FeatureCard({this.icon, this.title, this.margin, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3.0),
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      margin: this.margin,
      width: 152.0,
      child: InkWell(
        onTap: this.onTap,
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(
                this.icon,
                size: 72.0,
              ),
              height: 99.0,
            ),
            Container(
              height: 55.0,
              child: Center(
                child: Text(
                  '$title',
                  style: TextStyle(
                      fontFamily: 'Aeonik',
                      fontSize: 20.0,
                      color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
