import 'package:flutter/material.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/screens/authentication/create_account_screen.dart';
import 'package:tongnyampah/screens/authentication/sign_in_screen.dart';
import 'package:tongnyampah/screens/home/home.dart';
import 'package:tongnyampah/screens/wrapper.dart';
import 'package:tongnyampah/services/auth.dart';
import 'package:tongnyampah/styles.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: Color(0xFF070707),
            textTheme: TextTheme(
                title: Styles.TitleTextStyle,
                subtitle: Styles.SubtitleTextStyle,
                body1: Styles.BodyTextStyle)),
        home: Wrapper(),
        onGenerateRoute: _routes(),
      ),
    );
  }
}

const SignInRoute = '/signin';
const CreateAccountRoute = '/register';
const HomeRoute = '/home';
const WrapperRoute = '/wrap';

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    print(arguments);
    switch (settings.name) {
      case SignInRoute:
        screen = SignInScreen();
        print(arguments);
        break;
      case CreateAccountRoute:
        print(arguments);
        screen = CreateAccountScreen();
        break;
      case HomeRoute:
        print(arguments);
        screen = Home(name: arguments["name"], point: arguments["point"],);
        break;
      case WrapperRoute:
        screen = Wrapper();
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}