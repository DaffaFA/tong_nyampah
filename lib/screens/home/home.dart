import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class Home extends StatefulWidget {
  final String name;
  final int point;

  Home({this.name, this.point});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add, size: 30, color: Colors.white,),
            Icon(Icons.list, size: 30, color: Colors.white,),
            Icon(Icons.compare_arrows, size: 30, color: Colors.white,),
            Icon(Icons.call_split, size: 30, color: Colors.white,),
            Icon(Icons.perm_identity, size: 30, color: Colors.white,),
          ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.chat,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          print('gs');
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('halo'),
            )
          ],
        ),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Builder(
                      builder: (context) => GestureDetector(
                        child: Icon(
                          Icons.menu,
                          size: 35.0,
                          color: Color(0xFF070707),
                        ),
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    // GestureDetector(
                    //   child: Icon(
                    //     Icons.menu,
                    //     size: 35.0,
                    //     color: Color(0xFF070707),
                    //   ),
                    // ),
                    GestureDetector(
                      child: Icon(
                        Icons.notifications,
                        size: 35.0,
                        color: Color(0xFF070707),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(38.0, 36.0, 38.0, 0),
                child: Text(
                  'Hi, ${widget.name}',
                  style: TextStyle(
                    fontSize: 42.0,
                    fontFamily: 'Aeonik',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(38.0, 0, 38.0, 0),
                child: Text(
                  '${widget.point} Point',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: 'Aeonik',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(38.0, 40.0, 38.0, 0),
                child: Text(
                  'Get Points !',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: 'Aeonik',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15.0),
                height: 175.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 38.0),
                        width: 152.0,
                        child: Column(),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 15.0),
                        width: 152.0,
                        child: Column(),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 15.0, right: 38.0),
                        width: 152.0,
                        child: Column(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(38.0, 35.0, 38.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Store',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'Aeonik',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          'See more',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Aeonik',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 15.0,
                ),
                margin: EdgeInsets.only(bottom: 50.0),
                height: 175.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 38.0),
                        width: 152.0,
                        child: Column(),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 15.0),
                        width: 152.0,
                        child: Column(),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 15.0, right: 38.0),
                        width: 152.0,
                        child: Column(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
