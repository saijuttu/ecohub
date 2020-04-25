import 'package:flutter/material.dart';
import 'package:ecohub_app/feed.dart';
import 'package:ecohub_app/profile.dart';
import 'package:ecohub_app/main.dart';

class Dashboard extends StatelessWidget {
  final String userId;
  final MyAppState myapp;
  const Dashboard({
    Key key,
    this.userId,
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
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.beach_access)),
                Tab(icon: Icon(Icons.border_top)),

              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              new Profile(userId: userId),
              new Feed()
            ],
          ),
        ),
      ),
    );
  }
}