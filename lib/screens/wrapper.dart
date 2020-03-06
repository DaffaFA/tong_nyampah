import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/screens/account_menu.dart';
import 'package:tongnyampah/screens/authentication/sign_in_screen.dart';
import 'package:tongnyampah/screens/blog_menu.dart';
import 'package:tongnyampah/screens/camera_menu.dart';
import 'package:tongnyampah/screens/home/home.dart';
import 'package:tongnyampah/screens/shop_menu.dart';
import 'package:tongnyampah/services/auth.dart';

class Wrapper extends StatefulWidget {
  final int page;

  Wrapper({this.page});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;
  String name = '';
  String initialName = '';

  void getUserData(user) {
    user.data.then((val) {
      setState(() {
        name = val["name"];
        initialName = name.split(" ").map((nam) => nam.substring(0, 1)).join();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final List<Widget> _listPage = <Widget>[
      Home(),
      ShopMenu(),
      CameraMenu(),
      BlogMenu(),
      AccountMenu(),
    ];
    final _auth = AuthService();
    if (user == null) {
      return SignInScreen();
    } else {
      getUserData(user);
      return Scaffold(
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
        backgroundColor: Color(0xFFFFFFFF),
        bottomNavigationBar: CurvedNavigationBar(
          key: this._bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.camera,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.book,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.perm_identity,
              size: 30,
              color: Colors.white,
            ),
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
        body: _listPage[_page],
      );
    }
  }
}
