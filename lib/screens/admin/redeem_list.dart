import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';
import 'package:tongnyampah/widgets/waiting_gift_list.dart';

class RedeemList extends StatefulWidget {
  @override
  _RedeemListState createState() => _RedeemListState();
}

class _RedeemListState extends State<RedeemList> {
  String resultBarcode;
  String codeBar;

  Future scanBarcode(String docId) async {
    try {
      await DatabaseService()
          .getRedeemByDocId(docId)
          .then((onValue) => codeBar = onValue.data["code"]);
      String barcode = await BarcodeScanner.scan();
      setState(() => resultBarcode = barcode);
      if ( codeBar == resultBarcode ) {
        DatabaseService().setStatusRedeem(docId, 'complete');
      }
    } catch (e) {
      print(e);
    }
  }

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
                        onPressed: () async {
                          await DatabaseService()
                              .setStatusRedeem(docId, 'denied');
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                        child: Text('DENY'),
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () async {
                          await DatabaseService()
                              .setStatusRedeem(docId, 'confirmed');
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                        child: Text('CONFIRM'),
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
                              onTap: () async {
                                if (val.data["status"] == 'waiting') {
                                  showCancelDialog(context, val.documentID);
                                } else if (val.data["status"] == 'confirmed') {
                                  scanBarcode(val.documentID);
                                }
                              },
                              giftUid: val.data["gifts_uid"],
                              userUid: val.data["user_uid"],
                              isAdmin: true,
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
