import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class OrgDash extends StatefulWidget {
  final String userId;
  final MyAppState myapp;
  final BaseAuth auth;
  const OrgDash({
    Key key,
    this.userId,
    this.auth,
    @required this.myapp,
  }) : super(key: key);

  void _submit(){
    this.myapp.changePage(PageType.ORGANIZE);
  }

  void _logout(){
    auth.signOut();
    this.myapp.changePage(PageType.LOGIN);
    this.myapp.setState((){
      myapp.userId = "";
      myapp.authState = AuthStatus.NOT_LOGGED_IN;
      myapp.email = "";
      myapp.imageUrl = "";
    });
  }

  @override
  OrgDashState createState() => OrgDashState();
}

class OrgDashState extends State<OrgDash> {
  final formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(backgroundColor: Colors.red,
                  child: Icon(Icons.exit_to_app),
                  onPressed: (){
                    widget._logout();
                  }
              ),
            ),),

          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                child: const Icon(Icons.check),
                onPressed:(){
                  print("update");
                  widget._submit();
                }
            ),

          ),
        ],
      )

    );
  }
}
