import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          child: Image.asset(
            'assets/images/brand.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Center(
            child: SpinKitCircle(
              color: Color(0xFF070707),
            ),
          ),
        )
      ],
    );
  }
}
