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
          body: new TabBarView(

            children: [
            new ListView(
              children:list
              //new feed.Feed(),



            ),
              new ListView(
            children: list
            //new profile.Profile(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
List<Widget> list = <Widget>[
new ListTile(

title: new Text('China',
style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 50.0)),
subtitle: new Text('Hours 10000'),
onTap: (){
  print("11"); //this si the on tap for t
},

),
new ListTile(
title: new Text('Africa',
style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 50.0)),
subtitle: new Text('Hours 1'),

  onTap: (){
    print("11"); //this si the on tap for t
  },
trailing:  SizedBox(
  width: 50,
 height: 100,
  child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),

),
)

//  isThreeLine: true,





];