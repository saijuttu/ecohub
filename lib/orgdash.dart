import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'main.dart';
import 'maps.dart';

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
    this.myapp.changePageWithData(PageType.ORGANIZE, [LocationData("", "", "")]);
  }

  void _logout(){
    Auth().signOut();
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
  QuerySnapshot documents;

  void wait() async {
    QuerySnapshot docs = await Firestore.instance.collection("events").getDocuments();
    setState(() {
      this.documents = docs;
    });
  }

  Widget BlogList(){
    wait();
    if(documents==null){
      return new Loading();
    }
    return Stack(
        children: <Widget>[
          Container(
            child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal:16, vertical: 16),
                    itemCount: documents.documents.length,
                    shrinkWrap: true,
                    itemBuilder:(context,index){
                      return documents.documents[index].data["organizerID"] == widget.userId ? BlogsTile(
                          myapp: widget.myapp,
                          title: "Event",
                          imgUrl: documents.documents[index].data['imageUrl'],
                          description: documents.documents[index].data["description"],
                          date: "date",
                          hours: "${documents.documents[index].data["hours"]}",
                          organizer: documents.documents[index].data["organizerID"],
                          location: documents.documents[index].data["address"],
                          userList: documents.documents[index].data["userList"],
                          eventId: documents.documents[index].documentID,
                      ):Container();
                    }
                ),
              )
            ],
          ),
          ),
          Padding(padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(backgroundColor: Colors.green,
                  child: Icon(Icons.exit_to_app),
                  onPressed: (){
                    widget._logout();
                  }
              ),
            ),),
          Padding(padding: EdgeInsets.only(right:31),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                  onPressed:(){
                    print("update");
                    widget._submit();
                  }
              ),

            ),
          )


        ],

      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "eco",
              style: TextStyle(fontSize: 27,color: Colors.green),
            ),
            Text(
              "hub",
              style: TextStyle(fontSize: 27, color: Colors.white),
            )
          ]
        )
      ),
      body: BlogList(),
      backgroundColor: Colors.black87,


    );
  }
}

class BlogsTile extends StatelessWidget {

  String imgUrl, title, description, date, hours, organizer, location, eventId;
  List<dynamic> userList;
  MyAppState myapp;
  BlogsTile({
    @required this.imgUrl,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.hours,
    @required this.organizer,
    @required this.location,
    @required this.myapp,
    @required this.userList,
    @required this.eventId,
  });

  openTile(){
    print(title);
    myapp.setLoading(true);
    List data = [this.imgUrl, this.title, this.description, this.date, this.hours, this.organizer,this.location, this.userList, this.eventId];
    myapp.changePageWithData(PageType.EVENTVIEWORG,data);
    if(myapp.currentPage == PageType.EVENTVIEWORG){
      myapp.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          openTile();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          height: 150,
          child: Stack(children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                    imgUrl,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover)
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)
              ),

            ),

            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(title,
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("$hours Hours",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(location,
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)
                      ),
                    ])
            )
          ],),
        )
    );
  }
}

