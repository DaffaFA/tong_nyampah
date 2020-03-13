import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:tongnyampah/widgets/report_card.dart';

class BlogList extends StatefulWidget {
  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
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
                      'List of post',
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
              stream: DatabaseService().getAllPost(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: snapshot.data.documents
                              .map(
                                (val) => ReportCard(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   '/report/show',
                                    //   arguments: {
                                    //     "documentId": val.documentID,
                                    //     "uid": val.data["user_uid"],
                                    //     "type": val.data["type"],
                                    //   },
                                    // );
                                  },
                                  description: val.data["description"],
                                  title: val.data["title"],
                                  image: val.data["image"],
                                ),
                              )
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
