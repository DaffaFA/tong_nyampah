import 'package:flutter/material.dart';
import 'package:tongnyampah/widgets/setting_card.dart';

class AccountMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        'DDF',
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
                            'Daffa Dziban Fadia',
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        Container(
                          child: Text(
                            'daffadf562@gmail.com',
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
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('shiranani')));
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
