import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Text('Profile Page',
                style: new TextStyle(fontSize: 25.0, color: Colors.purple )
            )
        )
    );
  }
}