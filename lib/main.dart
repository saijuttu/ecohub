import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
    Widget home = new Login(auth: Auth(), myapp: this, title: "LOGIN", );
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

class _LoginState extends State<Login> {
  String emessage = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return Scaffold
      (
      backgroundColor: Color.fromRGBO(44, 47, 51, 1),
      body: Padding
        (
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column
          (
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>
          [
            Text('EcoHub',style: TextStyle(fontSize: 50,color: Color.fromRGBO(42, 222, 42, 1)),),
            Text('____________________________',style: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),),
            SizedBox(height: 100),

            TextField(textAlign: TextAlign.center, controller: emailController, style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
              ),
            ),
            SizedBox(height: 20),

            TextField(textAlign: TextAlign.center,controller: passwordController,style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
              ),
            ),
            SizedBox(height: 20),

            RaisedButton(color: Color.fromRGBO(42, 222, 42, 1),
                onPressed: () async {
                  widget._login(emailController.text, passwordController.text);
                  setState(() {
                    emessage = "Invalid username or password";
                  });
                },
                child: const Text('Login', style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            SizedBox(height: 20),
            Text("$emessage")
          ],
        ),
      ),
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  const Login({
    Key key,
    this.auth,
    this.title,
    @required this.myapp,
  }) : super(key: key);

  final BaseAuth auth;
  final _MyAppState myapp;
  final String title;


  void _login(String email, String password) async {
    String userId = await auth.signIn(email.trim(), password.trim());
    if(userId.length > 0) {
      this.myapp.setState(() {
        myapp.userId = userId;
        myapp.authState = AuthStatus.LOGGED_IN;
      });
      this.myapp.changePage(Page.PROFILE);
    }else{
      print("Failed to login");
    }
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


