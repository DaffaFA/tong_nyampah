import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String subtitle;
  final Function onTap;

  SettingCard({this.title, this.prefixIcon, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: Icon(
                      this.prefixIcon,
                      size: 32.0,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Container(
                          child: Text(
                            subtitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
