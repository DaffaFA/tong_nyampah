import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:tongnyampah/widgets/waiting_gift_list.dart';

class RedeemList extends StatefulWidget {
  @override
  _RedeemListState createState() => _RedeemListState();
}

class _RedeemListState extends State<RedeemList> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
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
              stream: DatabaseService().getAllWaitingGift(),
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: snapshot.data.documents
                        .map((val) => WaitingGiftList(
                              giftUid: val.data["gifts_uid"],
                              userUid: val.data["user_uid"],
                              status: val.data["status"],
                            ))
                        .toList(),
                  ),
                );
                // : Center(
                //     child: Text('Empty'),
                //   );
              },
            ),
          ],
        ),
      ),
    );
  }
}
