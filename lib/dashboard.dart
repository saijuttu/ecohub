import 'package:flutter/material.dart';
import 'package:ecohub_app/feed.dart';
import 'package:ecohub_app/profile.dart';
import 'package:ecohub_app/main.dart';

class Dashboard extends StatelessWidget {
  final String userId;
  final MyAppState myapp;
  final String username;
  final String imageURL;
  final int score;
  final String email;
  const Dashboard({
    Key key,
    this.userId,
    this.username,
    this.imageURL,
    this.score,
    this.email,
    @required this.myapp,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ecohub'),
            backgroundColor: Color(0xFF006400), // or if you want black put Color(0xFF000000)
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.beach_access)),
                Tab(icon: Icon(Icons.border_top)),

              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              new Profile(userId: this.userId, username: this.username, imageURL: this.imageURL, score: this.score,email: this.email, myapp: this.myapp),
              new Feed(myapp: this.myapp)
            ],
          ),
        ),
      ),
    );
  }
}