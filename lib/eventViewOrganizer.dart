import 'package:ecohub_app/loading.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventViewOrganizer extends StatefulWidget {
  const EventViewOrganizer({
    Key key,
    this.auth,
    this.userId,
    @required this.imgUrl,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.hours,
    @required this.organizer,
    @required this.location,
    @required this.userList,
    @required this.eventId,
    @required this.myapp,
  }) : super(key: key);

  final BaseAuth auth;
  final MyAppState myapp;
  final String userId;
  final String imgUrl, title, description, date, hours, organizer, location, eventId;
  final List userList;

  @override
  EventViewOrganizerState createState() => EventViewOrganizerState();
}

class EventViewOrganizerState extends State<EventViewOrganizer>
{
  EventViewOrganizerState()
  {
    wait();
    wait2();
  }
  QuerySnapshot profiles;

  void wait() async {
    QuerySnapshot docs = await Firestore.instance.collection("profiles").getDocuments();
    setState(() {
      this.profiles = docs;
    });
  }
  QuerySnapshot events;

  void wait2() async {
    QuerySnapshot docs = await Firestore.instance.collection("events").getDocuments();
    setState(() {
      this.events = docs;
    });
  }

  String _url = "";
  String _url2 = "";
  void imageGet(StorageReference ref) async
  {//call this async method from whereever you need
    String url = (await ref.getDownloadURL()).toString();
    setState(() {
      _url = url;
    });
  }
  void imageGetProfile(StorageReference ref) async
  {//call this async method from whereever you need
    String url = (await ref.getDownloadURL()).toString();
    setState(() {
      _url2 = url;
    });
  }

  void addEventToUser(userId) async{
    QuerySnapshot allDocuments = await Firestore.instance.collection("profiles").getDocuments();


    for(int i = 0; i< allDocuments.documents.length; i++){


      if(allDocuments.documents[i].documentID == userId)
      {
        print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');

        List<dynamic> eventList = allDocuments.documents[i].data["eventLog"];
        print(eventList.toString());

        List<dynamic> hourList = allDocuments.documents[i].data["hourLog"];
        print(hourList.toString());

        eventList.add(widget.eventId);
        hourList.add(widget.hours);
        print(eventList.toString());
        print(hourList.toString());

        print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');

        await Firestore.instance.collection("profiles").document(userId).updateData({"eventLog":eventList});
        await Firestore.instance.collection("profiles").document(userId).updateData({"hourLog":hourList});
      }
    }
  }

  void removeUserFromEvent(String id)
  {
    String docId=null;
    List subList = new List();
    for(int x=0;x<events.documents.length;x++)
    {
      if(events.documents[x].data["Location"]==widget.location)
      {
        docId = events.documents[x].documentID;
        subList = events.documents[x].data["submissionList"];
        print(subList.toString());
      }
    }
    if(docId!=null)
    {
      print('hi');
      for(int x=0;x<subList.length;x++)
      {
        print('ss');
        String line = subList[x];

        print(line.contains(id));
        print('hddi');
        if(line.contains(id))
        {
          subList.removeAt(x);
          print(subList.toString());
          break;
        }
      }

      widget.userList.remove(id);
      Firestore.instance.collection('events').document(docId).updateData({'userList': widget.userList, 'submissionList': subList});

    }

  }

  void increaseUserHours(String id)
  {
    int hours=-1;
    for(int x=0;x<profiles.documents.length;x++)
    {
      if(profiles.documents[x].documentID==id)
        hours=profiles.documents[x].data["score"]+int.parse(widget.hours.substring(0,1));
    }
    if(hours!=-1)
    {
      Firestore.instance.collection('profiles').document(id).updateData({'score': hours});
    }

  }

  Widget volunteerRow(String username, String profilePic, String submissionPic, String userId)
  {


    return new Container(


      child: Row
        (mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>
        [
          Expanded
            (
            child: FittedBox
              (
              fit: BoxFit.scaleDown,
              child: FloatingActionButton
                (
                  child: const Icon(Icons.cancel),
                  backgroundColor: Colors.red,
                  onPressed: () {removeUserFromEvent(userId);setState(() {});}
              ),
            ),
          ),

          Expanded
            (
            child: FittedBox
              (
              fit: BoxFit.contain,
              // otherwise the logo will be tiny
              child: Image
                (
                image: NetworkImage(
                    profilePic
                ),
              ),
            ),
          ),
          Expanded
            (
            child: FittedBox
              (
              fit: BoxFit.contain,
              // otherwise the logo will be tiny
              child: Text(username),
            ),
          ),

          Expanded
            (
            child: FittedBox
              (
              fit: BoxFit.contain,
              // otherwise the logo will be tiny
              child: Image
                (
                image: NetworkImage(
                    submissionPic),
              ),
            ),
          ),
          Expanded
            (
            child: FittedBox
              (
              fit: BoxFit.scaleDown,
              child: FloatingActionButton
                (
                  child: const Icon(Icons.check),
                  backgroundColor: Colors.green,
                  onPressed: () {addEventToUser(userId);removeUserFromEvent(userId);increaseUserHours(userId);setState(() {});}
              ),
            ),
          ),

        ],
      ),


    );




  }

  Widget volunteerList()
  {
    List<Widget> ll = [];
    //print(documents2==null);
    for(int x=0;x<widget.userList.length;x++)
    {
      String username;
      String profilePic;
      String uId;
      String subPic;
      if(profiles!=null && events != null) {
        for (int xx = 0; xx < profiles.documents.length; xx++) {
          if (profiles.documents[xx].documentID == widget.userList[x]) {
            uId = profiles.documents[xx].documentID;
            username = profiles.documents[xx].data["username"];
            StorageReference ref = FirebaseStorage.instance.ref().child(
                "images/$uId");
            imageGetProfile(ref);
            profilePic = _url2;

            List subList = [];
            for (int x = 0; x < events.documents.length; x++) {
              if (events.documents[x].data["Location"] ==
                  widget.location) {
                subList = events.documents[x].data["submissionList"];
              }
            }
            for (int x = 0; x < subList.length; x++) {
              String line = subList[x];
              if (line.contains(uId)) {
                StorageReference ref = FirebaseStorage.instance.ref().child(
                    "submissions/$line");
                imageGet(ref);
                subPic = _url;
                break;
              }
            }
          }
        }
      }else{
        Loading();
      }
      if(profilePic!=null && _url!=null&&subPic!=null) {

        Widget w = volunteerRow(username, profilePic, subPic, uId);
        ll.add(w);
      }else{
        return Loading();
      }
    }
    if(ll==null) {
      return Text("HELPLME ");
    }
    return new Column(children: ll);
  }

  @override
  Widget build(BuildContext context)
  {

    print(widget.description);
    return Stack(

      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.black87,

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
                      style: TextStyle(fontSize: 27),
                    )
                  ]
              )
          ),
          body: Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15.0)
                )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:0, vertical:0),

              child: ListView(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          child:  Image.network(
                            this.widget.imgUrl,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.85,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.black.withAlpha(0),
                                Colors.black12,
                                Colors.black45
                              ],
                            ),
                          ),
                          child: Text(
                            '${this.widget.title}',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'SCROLL UP',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(192, 192, 192, 1)
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0, 2),
                      child: Text(
                        '${this.widget.hours}',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,5,0, 20),
                      child: Text(
                        'HOURS',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(192, 192, 192, 1)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'DESCRIPTION',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(192, 192, 192, 1)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                    child: Text(
                      '${this.widget.description}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
                    child: Text(
                      'MAP',
                      style: TextStyle(
                          fontSize: 20,

                          color: Color.fromRGBO(192, 192, 192, 1)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),

                    child: Text(
                      'Volunteer List',
                      style: TextStyle(
                          fontSize: 20,

                          color: Color.fromRGBO(192, 192, 192, 1)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),

                    child: volunteerList(),
                  ),



                ],
              ),

            )

          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 22 ),
          child: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
                child: const Icon(Icons.arrow_back_ios),
                backgroundColor: Colors.transparent,

                onPressed: (){
                  print("Cancel");
                  widget.myapp.setLoading(true);
                  widget.myapp.changePage(PageType.ORGDASH);
                  if(widget.myapp.currentPage == PageType.ORGDASH){
                    widget.myapp.setLoading(false);
                  }


                }
            ),
          ),
        )

      ],
    );
  }
}



