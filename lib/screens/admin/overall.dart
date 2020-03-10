import 'package:flutter/material.dart';

class Overall extends StatefulWidget {
  @override
  _OverallState createState() => _OverallState();
}

class _OverallState extends State<Overall> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Text('halo'),
        ),
      ),
    );
  }
}
