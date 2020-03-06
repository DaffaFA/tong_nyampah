import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tongnyampah/widgets/setting_card.dart';
import 'package:tongnyampah/models/User.dart';

class AccountMenu extends StatefulWidget {
  @override
  _AccountMenuState createState() => _AccountMenuState();
}

class _AccountMenuState extends State {
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

    getUserData(user);

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: 85.0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF070707),
                      child: Text(
                        '$initialName',
                        style:
                            TextStyle(fontSize: 18.0, color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            '$name',
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${user.email}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFF070707),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SettingCard(
                    prefixIcon: Icons.edit,
                    title: 'Edit Account',
                    subtitle: 'Change your account profile',
                    onTap: () {
                      Navigator.pushNamed(context, '/account/edit');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
