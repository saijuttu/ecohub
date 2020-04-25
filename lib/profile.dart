import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/main.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String userId;
  final MyAppState myapp;
  final String username;
  final String imageURL;
  final int score;
  final String email;
  const Profile({Key key,
    this.userId,
    this.username,
    this.imageURL,
    this.score,
    this.email
    @required this.myapp,
  }) : super(key: key);


  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final formKey= GlobalKey<FormState>();
  void _submit(){


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                  child: Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                              width: 190.0,
                              height: 190.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                         imageURL)
                                  )
                              )),
                        ],
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                child:Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              Center(
                child: Text(
                  email,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                child:Text(
                  'Username',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              Center(
                child: Text(
                  username,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                child: Center(
                  child: Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Center(
                  child: Text(
                    'Total Hours',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(192, 192, 192, 1)
                    ),
                  ),
                ),
              ),
            ],
          )
      ),

    );

  }
}

