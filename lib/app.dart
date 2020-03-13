import 'package:flutter/material.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:tongnyampah/screens/admin/add_gifts.dart';
import 'package:tongnyampah/screens/admin/blog_add.dart';
import 'package:tongnyampah/screens/admin/fullscreen_image.dart';
import 'package:tongnyampah/screens/admin/report_show.dart';
import 'package:tongnyampah/screens/authentication/create_account_screen.dart';
import 'package:tongnyampah/screens/authentication/sign_in_screen.dart';
import 'package:tongnyampah/screens/blog_show.dart';
import 'package:tongnyampah/screens/edit_profile.dart';
import 'package:tongnyampah/screens/gift_description.dart';
import 'package:tongnyampah/screens/home/home.dart';
import 'package:tongnyampah/screens/notification_list.dart';
import 'package:tongnyampah/screens/report_screen.dart';
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
const NotificationRoute = '/notification';
const EditProfileRoute = '/account/edit';
const ReportRoute = '/report';
const ReportShowRoute = '/report/show';
const GiftDescriptionRoute = '/gift/description';
const FullScreenImageRoute = '/report/show/image';
const GiftAddRoute = '/gift/add';
const BlogAddRoute = '/blog/add';
const BlogShowRoute = '/blog/show';

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
        screen = Home();
        break;
      case WrapperRoute:
        screen = arguments["page"] != null
            ? Wrapper(page: arguments["page"])
            : Wrapper(page: 1);
        break;
      case NotificationRoute:
        screen = NotificationList();
        break;
      case EditProfileRoute:
        screen = EditProfile();
        break;
      case ReportRoute:
        screen = ReportScreen(
          type: arguments["type"],
          image: arguments["image"],
        );
        break;
      case ReportShowRoute:
        screen = ReportShow(
          documentId: arguments["documentId"],
          uid: arguments["uid"],
          type: arguments["type"],
        );
        break;
      case GiftDescriptionRoute:
        screen = GiftDescription(
          image: arguments["image"],
          description: arguments["description"],
          title: arguments["title"],
          point: arguments["point"],
          documentId: arguments["documentId"],
        );
        break;
      case FullScreenImageRoute:
        screen = FullScreenImage(arguments["image"]);
        break;
      case GiftAddRoute:
        screen = AddGifts(arguments["image"]);
        break;
      case BlogAddRoute:
        screen = BlogAdd(arguments["image"]);
        break;
      case BlogShowRoute:
        screen = BlogShow(
          title: arguments["title"],
          image: arguments["image"],
          description: arguments["description"],
          timestamp: arguments["timestamp"],
        );
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
