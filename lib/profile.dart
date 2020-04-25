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
    return Text(
      "$userId",
    );
  }
}
//=======
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
//>>>>>>> 2081e304b35317b292e1d01b2b9cfa04ccbc453c
