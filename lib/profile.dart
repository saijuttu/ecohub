import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String userId;
  const Profile({
    Key key,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Text('$userId',
                style: new TextStyle(fontSize: 25.0, color: Colors.purple )
            )
        )
    );
  }
}
//import 'package:flutter/material.dart';
//
//class Profile extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//        child: new Center(
//            child: new Text('Profile Page',
//                style: new TextStyle(fontSize: 25.0, color: Colors.purple )
//            )
//        )
//    );
//  }
//}
