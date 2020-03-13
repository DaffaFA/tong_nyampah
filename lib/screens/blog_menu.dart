import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:tongnyampah/widgets/navbar.dart';
import 'package:tongnyampah/widgets/news_card.dart';

class BlogMenu extends StatefulWidget {
  @override
  _BlogMenuState createState() => _BlogMenuState();
}

class _BlogMenuState extends State<BlogMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Navbar(condition: 'search'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Your daily read',
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: DatabaseService().getAllPost(),
                    builder: (context, snapshot) {
                      return Column(
                        children: snapshot.data.documents
                            .map((val) => NewsCard(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/blog/show',
                                      arguments: {
                                        "image": val.data["image"],
                                        "title": val.data["title"],
                                        "description": val.data["description"],
                                        "timestamp": val.data["created_at"]
                                            .toDate()
                                            .toString()
                                      }),
                                  image: val.data["image"],
                                  title: val.data["title"],
                                  timestamp: val.data["created_at"]
                                      .toDate()
                                      .toString(),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
