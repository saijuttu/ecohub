import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ecohub_app/eventView.dart';


void main() => runApp(MyApp(authState: AuthStatus.NOT_LOGGED_IN));

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
    this.authState,
    this.auth,
    this.userId,
  }) : super(key: key);

  final AuthStatus authState;
  final BaseAuth auth;
  final String userId;

  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  AuthStatus authState;
  BaseAuth auth;
  String userId;


  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new EventView(auth: Auth(), myapp: this),
      );
  }
}
