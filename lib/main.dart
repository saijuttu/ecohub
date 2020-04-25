import 'package:ecohub_app/maps.dart';
import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/register.dart';
import 'package:ecohub_app/login.dart';
import 'package:ecohub_app/profile.dart';
import 'package:ecohub_app/orgdash.dart';
import 'package:ecohub_app/organize.dart';
import 'package:ecohub_app/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String username = "user.name";
  String imageUrl = "https://firebasestorage.googleapis.com/v0/b/ecohubfirebase.appspot.com/o/IMG_1734.JPG?alt=media&token=84aa8a1a-cc71-4bee-a798-a8dfdd57bfcb";
  int score = 0;
  String email = "email@email.com";

  void changePage(PageType newPage){
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {



    Widget home = new Login(auth: Auth(), myapp: this, title: "LOGIN", );
    switch(this.currentPage){
      case PageType.LOGIN: {
        home = Login(myapp:this);
      }
      break;
      case PageType.PROFILE:{
        Firestore.instance.collection('profiles').document(userId).get().then((string) {

          setState(() {
            username = string.data['username'];
            score = string.data['score'];
            if(string.data['organizer']){
              currentPage = PageType.ORGDASH;
            }
          });

        });
        home = Profile(userId: this.userId, username: this.username, imageURL: this.imageUrl, score: this.score,email: this.email, myapp: this);
      }
      break;
      case PageType.REGISTER:{

        home = Register(auth: Auth(), myapp: this);
      }
      break;
      case PageType.DASHBOARD:{
        Firestore.instance.collection('profiles').document(userId).get().then((string) {

          setState(() {
            username = string.data['username'];
            score = string.data['score'];
            if(string.data['organizer']){
              currentPage = PageType.ORGDASH;
            }
          });

        });

        home = Dashboard(userId: this.userId, username: this.username, imageURL: this.imageUrl, score: this.score,email: this.email, myapp:this);
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



