import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/main.dart';


class Login extends StatelessWidget {
  const Login({
    Key key,
    this.auth,
    this.title,
    @required this.myapp,
  }) : super(key: key);

  final BaseAuth auth;
  final MyAppState myapp;
  final String title;

  void _login() async {
    String userId = await auth.signIn("amelachuri@gmail.com", "password");

    this.myapp.setState((){
      myapp.userId = userId;
      myapp.authState = AuthStatus.LOGGED_IN;
    });
    this.myapp.changePage(Page.PROFILE);
    print("$userId");
  }

  void _toRegister(){
    this.myapp.changePage(Page.REGISTER);
  }

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
                  _login();
                },
                child: const Text('Login', style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            RaisedButton(color: Color.fromRGBO(42, 222, 42, 1),
                onPressed: () async {
                  _toRegister();
                },
                child: const Text('Register', style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
