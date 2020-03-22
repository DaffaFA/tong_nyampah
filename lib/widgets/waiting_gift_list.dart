import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';

class WaitingGiftList extends StatefulWidget {
  final Function onTap;
  final String status;
  final String giftUid;
  final bool isAdmin;
  final String userUid;

  WaitingGiftList({this.onTap, this.giftUid, this.status, this.userUid, this.isAdmin});

  @override
  _WaitingGiftListState createState() => _WaitingGiftListState();
}

class _WaitingGiftListState extends State<WaitingGiftList> {
  String gift;
  String image;
  String status;
  String description;
  int point;
  String name;

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
  
  Future<void> getUser() async {
    DatabaseService(uid: widget.userUid).getProfileData().then((value) {
      setState(() {
        name = value.data["name"].split(' ')[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllData();
    if ( widget.isAdmin == true ) {
      getUser();
    }
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
                      widget.isAdmin == false || widget.isAdmin == null ? 'Claim for $gift' : '$name claim for $gift' ,
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
