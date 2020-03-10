import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  List<Widget> _listPage = [
    Overall(),
    ReportList(),
    ReportList(),
  ];

  Choice _selectedChoice = Choice.getAllChoice()[0];

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    final user = Provider.of<User>(context);

    getUserData(user);

    screen = isLoading == null || isLoading == true
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: _page == 1
                  ? <Widget>[
                      PopupMenuButton(
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
                Icon(
                  Icons.compare_arrows,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.call_split,
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
      Choice(title: 'Car', icon: Icons.directions_car),
      Choice(title: 'Bicycle', icon: Icons.directions_bike),
      Choice(title: 'Boat', icon: Icons.directions_boat),
      Choice(title: 'Bus', icon: Icons.directions_bus),
      Choice(title: 'Train', icon: Icons.directions_railway),
      Choice(title: 'Walk', icon: Icons.directions_walk),
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
