import 'package:ecohub_app/maps.dart';
import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/register.dart';
import 'package:ecohub_app/login.dart';
import 'package:ecohub_app/profile.dart';
import 'package:ecohub_app/orgdash.dart';
import 'package:ecohub_app/organize.dart';
import 'package:ecohub_app/dashboard.dart';


void main() => runApp(MyApp());

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

enum PageType{
  LOGIN,
  PROFILE,
  REGISTER,
  DASHBOARD,
  ORGANIZE,
  ORGDASH,
  MAPS,
}

Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);
class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
    this.authState,
    this.auth,
    this.userId,
    this.currentPage,
  }) : super(key: key);

  final AuthStatus authState;
  final BaseAuth auth;
  final String userId;
  final PageType currentPage;

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  AuthStatus authState;
  BaseAuth auth;
  String userId;
  PageType currentPage;

  void changePage(PageType newPage){
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget home = new Login(auth: Auth(), myapp: this, title: "LOGIN", );
    switch(this.currentPage){
      case PageType.LOGIN: {}
      break;
      case PageType.PROFILE:{
        home = Profile(userId: this.userId, myapp:this);
      }
      break;
      case PageType.REGISTER:{
        home = Register(auth: Auth(), myapp: this);
      }
      break;
      case PageType.DASHBOARD:{
        home = Dashboard(userId: userId, myapp: this);
      }
      break;
      case PageType.ORGDASH:{
        home = OrgDash(userId: userId, myapp:this);
      }
      break;
      case PageType.ORGANIZE:{
        home = Organize(userId: userId, myapp:this);
      }
      break;
      case PageType.MAPS:{
        home = Maps(userId: userId, myapp:this);
      }
      break;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: home,
    );
  }
}



