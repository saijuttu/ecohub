import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp(authState: AuthStatus.NOT_LOGGED_IN, currentPage: Page.LOGIN,));

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

enum Page{
  LOGIN,
  PROFILE,
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
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
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
    Widget home = new Login(auth: Auth(), myapp: this);
    switch(this.currentPage){
      case Page.LOGIN:{}
      break;
      case Page.PROFILE:{
        home = Profile(userId: this.userId);
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

class Login extends StatelessWidget {
  const Login({
    Key key,
    this.auth,
//    @required this.toProfile,
    @required this.myapp,
  }) : super(key: key);

//  final void Function() toProfile;
  final BaseAuth auth;
  final _MyAppState myapp;

  void _login() async {
    String userId = await auth.signIn("amelachuri@gmail.com", "password");

    this.myapp.setState((){
      myapp.userId = userId;
      myapp.authState = AuthStatus.LOGGED_IN;
    });
    this.myapp.changePage(Page.PROFILE);
    print("$userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eco-Hub'),
        ),
        body: Center(
            child: FlatButton(
              onPressed: () async {
                _login();
              },
              child: Text(
                "Log In",
              ),
            )
        )
    )
    ;
  }
}

class Profile extends StatelessWidget {
  final String userId;
  const Profile({
    Key key,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$userId",
    );
  }
}


