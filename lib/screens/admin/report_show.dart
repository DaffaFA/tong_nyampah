import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/services/database.dart';

class ReportShow extends StatefulWidget {
  @required
  final String documentId;
  @required
  final String type;
  @required
  final String uid;

  ReportShow({
    this.type,
    this.documentId,
    this.uid,
  });

  @override
  _ReportShowState createState() => _ReportShowState();
}

class _ReportShowState extends State<ReportShow> {
  bool isLoading;
  String namePereport;

  void setStatus(context, status, uid) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    'Are you sure ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF070707),
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'This change cannot be revert',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF070707),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            child: Text('Cancel'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          DatabaseService().setStatusReport(
                              widget.documentId, status, widget.type, uid);
                        },
                        child: Container(
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(color: Color(0xFF070707)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void getUserData() {
    DatabaseService(uid: widget.uid).getProfileData().then((value) {
      setState(() {
        namePereport = value["name"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService().getReportByDocId(widget.documentId),
        builder: (context, snapshot) {
          return SingleChildScrollView(
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
                          image: NetworkImage(snapshot.data.data["image"]),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8),
                              BlendMode.dstATop)),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 13.0),
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
                                child: Center(
                                  child: Text(
                                    widget.type,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 13.0),
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/report/show/image',
                                    arguments: {
                                      "image": snapshot.data.data["image"]
                                    },
                                  ),
                                  child: Icon(
                                    Icons.fullscreen,
                                    size: 45.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 56.0, bottom: 25.0),
                            child: Container(
                              child: Text(
                                snapshot.data.data["title"],
                                style: TextStyle(
                                    fontSize: 34.0, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 38.0),
                    child: Text(snapshot.data.data["description"]),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 38.0),
                    child: Text('Reported by : $namePereport'),
                  ),
                  Container(
                    color: Colors.black,
                    margin: EdgeInsets.symmetric(horizontal: 38.0),
                    child: InkWell(
                      onTap: () => setStatus(
                          context, 'confirmed', snapshot.data.data["user_uid"]),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            'CONFIRM',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0.0, 3),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.2))
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 38.0, vertical: 12.0),
                    child: InkWell(
                      onTap: () => setStatus(
                          context, 'denied', snapshot.data.data["user_uid"]),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                            child: Text(
                          'DENY',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
