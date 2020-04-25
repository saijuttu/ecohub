import 'package:flutter/material.dart';
import './profile.dart' as profile;
import './feed.dart' as feed;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              new feed.Feed(),
              new profile.Profile()
            ],
          ),
        ),
      ),
    );
  }
}