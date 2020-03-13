import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/screens/admin/overall.dart';
import 'package:tongnyampah/screens/admin/report_list.dart';
import 'package:tongnyampah/screens/loading_screen.dart';
import 'package:tongnyampah/services/auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String name = '';
  String role = '';
  String initialName = '';
  bool isLoading;
  File _image;
  final _auth = AuthService();

  void getUserData(user) {
    user.data.then((val) {
      setState(() {
        isLoading = true;

        name = val["name"];
        role = val["role"];
        initialName = name.split(" ").map((nam) => nam.substring(0, 1)).join();
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  Choice _selectedChoice = Choice.getAllChoice()[0];
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  List<Widget> _listPage = [
    Overall(),
    ReportList(),
  ];

  Future _openCamera(BuildContext context, type) async {
    ImageSource tip = type == 'camera'
        ? ImageSource.camera
        : type == 'gallery' ? ImageSource.gallery : null;

    var picture = await ImagePicker.pickImage(
      source: tip,
      imageQuality: 50,
    );
    setState(() {
      _image = picture;
    });

    if (_image != null) {
      Navigator.pushNamed(context, '/gift/add', arguments: {
        "image": _image,
      });
    }
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: () => _openCamera(context, 'camera'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: () => _openCamera(context, 'gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
    print(_selectedChoice.title);
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    final user = Provider.of<User>(context);

    getUserData(user);

    screen = isLoading == null || isLoading == true
        ? LoadingScreen()
        : Scaffold(
            floatingActionButton: _page == 0
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.black,
                    onPressed: () => _optionsDialogBox(),
                  )
                : null,
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: _page == 1
                  ? <Widget>[
                      PopupMenuButton(
                        onSelected: (val) => _select(val),
                        itemBuilder: (BuildContext context) {
                          return Choice.getAllChoice().map((Choice choice) {
                            return PopupMenuItem<Choice>(
                              value: choice,
                              child: Text(choice.title),
                            );
                          }).toList();
                        },
                      )
                    ]
                  : null,
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      '$name',
                      style: TextStyle(color: Colors.white),
                    ),
                    accountEmail: Text(user.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        '$initialName',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Aeonik',
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sign out',
                      style: TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Icon(
                      Icons.exit_to_app,
                      size: 30.0,
                      color: Color(0xFF070707),
                    ),
                    onTap: () async {
                      await _auth.signOut();
                    },
                  )
                ],
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 50.0,
              items: <Widget>[
                Icon(
                  Icons.dashboard,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.report,
                  size: 30,
                  color: Colors.white,
                ),
              ],
              color: Colors.black,
              buttonBackgroundColor: Colors.black,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
            ),
            body: _listPage[_page],
          );
    return screen;
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;

  static List<Choice> getAllChoice() {
    return <Choice>[
      Choice(title: 'Waiting', icon: Icons.directions_car),
      Choice(title: 'Confirmed', icon: Icons.directions_bike),
      Choice(title: 'Denied', icon: Icons.directions_boat),
    ];
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
