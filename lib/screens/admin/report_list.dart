import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:tongnyampah/widgets/report_card.dart';

class ReportList extends StatefulWidget {
  // final String choice;

  // ReportList(this.choice);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  List<Widget> reports;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'List of report',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    child: Divider(
                      thickness: 3.0,
                      color: Color(0xFF070707),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseService().getAllReport(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: snapshot.data.documents
                              .where((doc) => doc["status"] == "waiting")
                              .map((val) => ReportCard(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/report/show',
                                        arguments: {
                                          "documentId": val.documentID,
                                          "uid": val["user_uid"],
                                          "type": val["type"],
                                        },
                                      );
                                    },
                                    description: val["description"],
                                    title: val["title"],
                                    image: val["image"],
                                  ))
                              .toList(),
                        ),
                      )
                    : Center(
                        child: Text('Empty'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
