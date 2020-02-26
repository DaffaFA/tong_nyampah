import 'package:flutter/material.dart';
import 'package:tongnyampah/screens/components/custom_text_field.dart';
import 'package:tongnyampah/services/auth.dart';
import 'package:tongnyampah/styles.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final AuthService _auth = AuthService();
  final _key = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: Styles.ContainerStyle,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: this._key,
                  child: Padding(
                    padding: EdgeInsets.only(left: 36.0, right: 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.025),
                          child: FlatButton(
                            child: Text(
                              'X',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Aeonik',
                                fontSize: 42.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            onPressed: () => this._backNavigation(context),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.06),
                          child: Text(
                            'CREATE ACCOUNT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Aeonik',
                              fontWeight: FontWeight.w900,
                              fontSize: 32.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.08),
                          child: CustomTextField(
                            placeholder: 'Full Name',
                            prefixIcon: Icons.people,
                            controller: _name,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.015),
                          child: CustomTextField(
                            placeholder: 'Email Address',
                            prefixIcon: Icons.mail_outline,
                            controller: _email,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.015),
                          child: CustomTextField(
                            placeholder: 'Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            controller: _password,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.12),
                          child: RaisedButton(
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Aeonik',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                            color: Color(0xFF070707),
                            onPressed: () =>
                                this._onSubmit(context, _name.text, _email.text, _password.text),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Container(
              height: MediaQuery.of(context).size.width * 0.18,
              child: Center(
                child: FlatButton(
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'Aeonik'),
                    ),
                    onPressed: () => this._backNavigation(context)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context,String name, String email, String password) async {
    dynamic result = await _auth.registerEmailAndPassword(name, email, password);
    if ( result != null ) {
      Navigator.pop(context);
    }
  }

  void _backNavigation(BuildContext context) {
    Navigator.pop(context);
  }
}
