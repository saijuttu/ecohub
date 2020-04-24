import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

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
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  AuthStatus authState;
  BaseAuth auth;
  String userId;


  @override
  Widget build(BuildContext context) {
    print(this.authState);
    if(this.authState!= AuthStatus.LOGGED_IN) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Login(auth: Auth(), myapp: this),
      );
    }
    else{
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Profile(userId: this.userId),
      );
    }
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

    this.myapp.setState((){myapp.userId = userId;myapp.authState = AuthStatus.LOGGED_IN;});
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


