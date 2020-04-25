import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/register.dart';
import 'package:ecohub_app/login.dart';
import 'package:ecohub_app/profile.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp(authState: AuthStatus.NOT_LOGGED_IN, currentPage: Page.LOGIN));

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

enum Page{
  LOGIN,
  PROFILE,
  REGISTER,
}

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
  final Page currentPage;

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  AuthStatus authState;
  BaseAuth auth;
  String userId;
  Page currentPage;

  void changePage(Page newPage){
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("authstate: $authState");
    Widget home = new Login(auth: Auth(), myapp: this, title: "LOGIN");
    switch(this.currentPage){
      case Page.LOGIN: {}
      break;
      case Page.PROFILE:{
        home = Profile(userId: this.userId);
      }
      break;
      case Page.REGISTER:{
        home = Register();
      }
      break;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }
}
