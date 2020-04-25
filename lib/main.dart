import 'package:flutter/material.dart';
import './profile.dart' as profile;
import './feed.dart' as feed;
import 'feed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ecohub'),
            bottom: TabBar(

              tabs: [
                Tab(icon: Icon(Icons.beach_access)),

              ],
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              new Feed()
            ]

//            children: [
//            new ListView(
//              scrollDirection: Axis.vertical,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(16.0),
//                  child: Container(
//                    child: FittedBox(
//                    child: Material(
//                      color: Colors.white,
//                      elevation:14.0,
//                      borderRadius: BorderRadius.circular(24.0),
//                      shadowColor: Color(0x802196F3),
//                        child: Row(
//                          children: <Widget>[
//                            Container(
//                              child: myDetailsContainer1()
//                            ),
//                            Container(
//                              height: 250,
//                              width: 250,
//                              child: ClipRRect(
//                                borderRadius: new BorderRadius.circular(24.0),
//                                child:Image(
//                                  fit:BoxFit.contain,
//                                  alignment: Alignment.topRight,
//                                  image: NetworkImage(
//                                      'https://images.unsplash.com/photo-1519501025264-65ba15a82390?ixlib=rb-1.2.1&w=1000&q=80'
//                                  )
//                                )
//                              )
//                            )
//                          ]
//                        )
//                    )
//                    )
//                  )
//                )
//              ]
//              //new feed.Feed(),
//            ),
//              new ListView(
//            children: list
//            //new profile.Profile(),
//              ),
//
//            ],
          ),
        ),
      ),
    );
  }
}

//Widget myDetailsContainer1() {
//  return Column(
//    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//    children: <Widget>[
//      Padding(
//        padding: const EdgeInsets.only(left: 8.0),
//        child: Container(child: Text("Candy Bliss",
//          style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
//      ),
//      Padding(
//        padding: const EdgeInsets.only(left: 8.0),
//        child: Container(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Container(child: Text("4.3",
//                  style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
//
//                Container(child: Text("(321) \u00B7 0.9 mi",
//                  style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
//              ],)),
//      ),
//      Container(child: Text("Pastries \u00B7 Phoenix,AZ",
//        style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
//    ],
//  );
//}
//
//List<Widget> list = <Widget>[
//new ListTile(
//
//title: new Text('China',
//style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 50.0)),
//subtitle: new Text('Hours 10000'),
//onTap: (){
//  print("11"); //this si the on tap for t
//},
//
//),
//new ListTile(
//title: new Text('Africa',
//style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 50.0)),
//subtitle: new Text('Hours 1'),
//
//  onTap: (){
//    print("11"); //this si the on tap for t
//  },
//trailing:  SizedBox(
//  width: 50,
// height: 100,
//  child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
//
//),
//)
//
////  isThreeLine: true,
//
//
//
//
//
//];