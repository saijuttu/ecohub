import 'package:flutter/material.dart';
import 'package:ecohub_app/feed.dart';
import 'package:ecohub_app/profile.dart';

class Dashboard extends StatelessWidget {
  final String userId;
  const Dashboard({
    Key key,
    this.userId
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