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

  Future scanBarcode(String docId, context, String uid, String giftId) async {
    try {
      await DatabaseService()
          .getRedeemByDocId(docId)
          .then((onValue) => codeBar = onValue.data["code"]);
      String barcode = await BarcodeScanner.scan();
      setState(() => resultBarcode = barcode);
      if (codeBar == resultBarcode) {
        DatabaseService().setStatusRedeem(docId, 'complete');
        DatabaseService().decreasePoint(uid, giftId);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Icon(
                        Icons.check,
                        size: 66.0,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'QR Code is Match',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: Text(
                        'The QR code is match, user can take the gifts',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Icon(
                        Icons.warning,
                        size: 66.0,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'QR Code is not Match',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: Text(
                        'The QR code not match, user can\'t take the gifts',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
            );
          },
        );
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
                    'Confirm this redeem ?',
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

  Future showDeleteDialog(context, docId) {
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
                    'Delete the report ?',
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
                        child: Text('EXIT'),
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
                                  scanBarcode(val.documentID, context, val.data["user_uid"], val.data["gifts_uid"]);
                                } else if (val.data["status"] == 'complete') {
                                  showDeleteDialog(context, val.documentID);
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
