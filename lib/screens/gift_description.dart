import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/services/database.dart';

class GiftDescription extends StatelessWidget {
  final String image;
  final String title;
  final int point;
  final String description;
  final String documentId;

  GiftDescription(
      {this.image, this.description, this.title, this.point, this.documentId});

  void redeemGift(context, giftId, userUid) {
    DatabaseService().createReportClaim(
      docId: giftId,
      uid: userUid,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 13.0, top: 10.0),
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.chevron_left,
                          size: 60.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 56.0, bottom: 25.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 34.0, color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                '$point Points required',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 38.0),
                child: Text('''$description'''),
              ),
              Container(
                color: Colors.black,
                margin: EdgeInsets.symmetric(horizontal: 38.0),
                child: InkWell(
                  onTap: () => redeemGift(context, documentId, _user.uid),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                        child: Text(
                      'REDEEM',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
