import 'package:flutter/material.dart';
import 'package:tongnyampah/screens/loading_screen.dart';

class ReportShow extends StatefulWidget {
  @required
  final String documentId;
  @required
  final String type;
  @required
  final String uid;

  ReportShow({
    this.type,
    this.documentId,
    this.uid,
  });

  @override
  _ReportShowState createState() => _ReportShowState();
}

class _ReportShowState extends State<ReportShow> {
  bool isLoading;

  void getAllData() {}

  @override
  Widget build(BuildContext context) {
    return isLoading || isLoading == null
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(title: Text('title')),
            bottomNavigationBar: Container(color: Colors.black),
          );
  }
}
