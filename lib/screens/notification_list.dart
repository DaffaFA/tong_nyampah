import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/services/database.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF070707),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: DatabaseService().getAllReport(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: snapshot.data.documents
                    .where((data) => data.data["user_uid"] == _user.uid)
                    .map((val) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.notifications_active,
                          ),
                          title: Text(val.data["title"]),
                          subtitle: Text(val.data["status"]),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
