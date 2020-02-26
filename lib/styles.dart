import 'package:flutter/material.dart';

class Styles {
  static const ContainerStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(35.0),
      bottomRight: Radius.circular(35.0),
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        offset: Offset(0, -10.0),
        color: Colors.black54,
        blurRadius: 30.0,
      )
    ],
  );

  static const TitleTextStyle = TextStyle(
    color: Color(0xFF070707),
    fontFamily: 'Aeonik',
    fontSize: 48.0,
    fontWeight: FontWeight.w900,
  );

  static const SubtitleTextStyle = TextStyle(
    color: Color(0xFF373737),
    fontFamily: 'Aeonik',
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
  );

  static const BodyTextStyle = TextStyle(
    color: Color(0xFF373737),
    fontFamily: 'Aeonik',
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );
}
