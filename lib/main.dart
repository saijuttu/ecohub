import 'package:ecohub_app/maps.dart';
import 'package:flutter/material.dart';
import 'package:ecohub_app/eventViewOrganizer.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/register.dart';
import 'package:ecohub_app/login.dart';
import 'package:ecohub_app/profile.dart';
import 'package:ecohub_app/orgdash.dart';
import 'package:ecohub_app/organize.dart';
import 'package:ecohub_app/dashboard.dart';
import 'package:ecohub_app/eventView.dart';
import 'package:ecohub_app/submit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohub_app/maps.dart';

import 'loading.dart';

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
  EVENTVIEW,
  SUBMIT,
  EVENTVIEWORG,
}

Map<int, Color> color =
{
  50:Color.fromRGBO(132, 196, 67, .1),
  100:Color.fromRGBO(132, 196, 67, .2),
  200:Color.fromRGBO(132, 196, 67, .3),
  300:Color.fromRGBO(132, 196, 67, .4),
  400:Color.fromRGBO(132, 196, 67, .5),
  500:Color.fromRGBO(132, 196, 67, .6),
  600:Color.fromRGBO(132, 196, 67, .7),
  700:Color.fromRGBO(132, 196, 67, .8),
  800:Color.fromRGBO(132, 196, 67, .9),
  900:Color.fromRGBO(132, 196, 67, 1),
};
MaterialColor colorCustom = MaterialColor(0xff84c443, color);
class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
    this.authState,
    this.auth,
    this.userId,
    this.currentPage,
    this.loading,
  }) : super(key: key);

  final AuthStatus authState;
  final BaseAuth auth;
  final String userId;
  final PageType currentPage;
  final bool loading;

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
  List  userList = new List();
  List data = [];
  bool loading = false;

  void setLoading(bool load){
    setState(() => loading = load);
  }

  void changePage(PageType newPage){
    setState(() {
      currentPage = newPage;
    });
  }

  void changePageWithData(PageType newPage, List data){

    setState(() {
      currentPage = newPage;
      this.data = data;

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
        if(data.length>0){
          print("THIS IS ADDRESS ${data[0].address}");
          home = Organize(userId: userId, myapp: this, eventData: data[0],);
        }else {
          print("data is emptyy");
          home = Organize(userId: userId, myapp: this,);
        }
      }
      break;
      case PageType.MAPS:{
        home = Maps(userId: userId, myapp:this);
      }
      break;
      case PageType.EVENTVIEW:{
        print(data);
        home = EventView(
            userId: userId,
            imgUrl: data[0],
            title: data[1],
            description: data[2],
            date: data[3],
            hours: data[4],
            organizer: data[5],
            location: data[6],
            eventId: data[7],
   //         userList: data[7],
            myapp:this);

      }
      break;
      case PageType.SUBMIT:{
        home = Submit(
            userId: userId,
            imgUrl: data[0],
            title: data[1],
            description: data[2],
            date: data[3],
            hours: data[4],
            organizer: data[5],
            location: data[6],
            eventId: data[7],
            myapp:this);
      }
      break;
      case PageType.EVENTVIEWORG:{
        home = EventViewOrganizer(
            userId: userId,
            imgUrl: data[0],
            title: data[1],
            description: data[2],
            date: data[3],
            hours: data[4],
            organizer: data[5],
            location: data[6],
            userList: data[7],
            eventId: data[8],
            myapp:this);

      }
    }

    if(loading)home = Loading();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: home,
    );
  }
}

