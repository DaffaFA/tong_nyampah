import 'package:flutter/material.dart';
import 'package:tongnyampah/app.dart';
import 'package:tongnyampah/screens/components/custom_text_field.dart';
import 'package:tongnyampah/services/auth.dart';
import 'package:tongnyampah/styles.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _key = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              decoration: Styles.ContainerStyle,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 36.0,
                  right: 36.0,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'SIGN IN',
                          style: Theme.of(context).textTheme.title,
                        ),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.13),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: CustomTextField(
                          placeholder: 'Email Address',
                          prefixIcon: Icons.mail_outline,
                          controller: _emailController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015),
                        child: CustomTextField(
                          placeholder: 'Password',
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01),
                        child: FlatButton(
                          child: Text(
                            'Forgot Password?',
                            style:
                                TextStyle(fontFamily: 'Aeonik', fontSize: 15.0),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.12),
                        child: RaisedButton(
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Aeonik',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          // textColor: Colors.white,
                          color: Color(0xFF070707),
                          onPressed: () => this._onSubmit(context, _emailController.text, _passwordController.text),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Center(
                child: FlatButton(
                  child: Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontFamily: 'Aeonik',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () => _onPressCreateAccount(context),
                ),

              ),
            )
          ],
        ),
      ),
    );
  }

  _onSubmit(BuildContext context, String email, String password) async {
    if ( _key.currentState.validate() ) {
     dynamic user = await _auth.signInEmailAndPassword(email.trim(), password);
     print(user);
    }
  }

  _onPressCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, CreateAccountRoute);
  }
}
