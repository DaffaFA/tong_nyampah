import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';

class WaitingGiftList extends StatefulWidget {
  final Function onTap;
  final String status;
  final String giftUid;
  final String userUid;

  WaitingGiftList({this.onTap, this.giftUid, this.status, this.userUid});

  @override
  _WaitingGiftListState createState() => _WaitingGiftListState();
}

class _WaitingGiftListState extends State<WaitingGiftList> {
  String gift;
  String image;
  String status;
  String description;
  int point;

  Future<void> getAllData() async {
    DatabaseService().getGiftByDocId(widget.giftUid).then((value) {
      setState(() {
        image = value.data["image"];
        gift = value.data["title"];
        point = value.data["point"];
        description = value.data["description"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllData();
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 6.5),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      // '${title.substring(0, 20)}',
                      'Claim for $gift',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      // timestamp.substring(0, 11),
                      'Status: ${widget.status}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image))),
            ),
          ],
        ),
      ),
    );
  }
}
