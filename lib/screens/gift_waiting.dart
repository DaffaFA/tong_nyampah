import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:tongnyampah/widgets/waiting_gift_list.dart';

class GiftWaiting extends StatelessWidget {
  Future showCancelDialog(context, docId) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Are you sure delete this redeem ?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.white,
                        child: Text('Exit'),
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () async {
                          await DatabaseService().cancelRedeem(docId);
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                        child: Text('DELETE'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        'Your waiting list',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Divider(
                      thickness: 1.3,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream:
                          DatabaseService().getAllWaitingGiftList(_user.uid),
                      builder: (context, snapshot) {
                        return Column(
                          children: snapshot.data.documents
                              .map((val) => WaitingGiftList(
                                    onTap: () async => await showCancelDialog(
                                        context, val.documentID),
                                    giftUid: val.data["gifts_uid"],
                                    userUid: _user.uid,
                                    status: val.data["status"],
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
      ),
    );
  }
}
