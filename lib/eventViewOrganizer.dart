import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/main.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  QuerySnapshot documents;

  void wait() async {
    QuerySnapshot docs = await Firestore.instance.collection("profiles").getDocuments();
    setState(() {
      this.documents = docs;
    });
  }
  QuerySnapshot documents2;

  void wait2() async {
    QuerySnapshot docs = await Firestore.instance.collection("events").getDocuments();
    setState(() {
      this.documents2 = docs;
    });
  }


  @override
  Widget build(BuildContext context)
  {

    void addEventToUser(userId) async{
      QuerySnapshot allDocuments = await Firestore.instance.collection("profiles").getDocuments();

      for(int i = 0; i< allDocuments.documents.length; i++){
        print(allDocuments.documents[i].documentID);
        if(allDocuments.documents[i].documentID == widget.userId)
        {
          String uid = widget.userId;
          List<dynamic> eventList = allDocuments.documents[i].data["eventList"];
          List<dynamic> hourList = allDocuments.documents[i].data["hourList"];
          eventList.add(widget.eventId);
          hourList.add(widget.hours);
          await Firestore.instance.collection("profiles").document(uid).updateData({"eventList":eventList});
          await Firestore.instance.collection("profiles").document(uid).updateData({"hourLIst":hourList});
        }
      }
    }

    void getUserLocation() async {//call this async method from whereever you need

      final coordinates = new Coordinates(29.791081, -95.808231);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
 //     print('ADRESSADRESSASDEAASDASDASD ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare} ADRESSADRESSASDEAASDASDASD');
   //   return first;
    }
    getUserLocation();
    void removeUserFromEvent(String id)
    {
      String docId=null;
      for(int x=0;x<documents2.documents.length;x++)
        {
          if(documents2.documents[x].data["Location"]==widget.location)
            docId=documents2.documents[x].documentID;
        }
      if(docId!=null) {
        widget.userList.remove(id);
        Firestore.instance.collection('events').document(docId).updateData({'userList': widget.userList});
      }

    }
    void increaseUserHours(String id)
    {
      int hours=-1;
      for(int x=0;x<documents.documents.length;x++)
      {
        if(documents.documents[x].documentID==id)
          hours=documents.documents[x].data["score"]+int.parse(widget.hours.substring(0,1));
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
                                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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
      List<Widget> ll = new List<Widget>();
      for(int x=0;x<widget.userList.length;x++)
      {
        String username;
        String profilePic;
        String userId;
        for(int xx=0;xx<documents.documents.length;xx++)
          {
            if(documents.documents[xx].documentID==widget.userList[x])
            {
              username = documents.documents[xx].data["username"];
              profilePic = documents.documents[xx].data["pic"];
              userId = documents.documents[xx].documentID;

            }


          }
        if(profilePic!=null) {
          print(profilePic);
          print(userId);
          Widget w = volunteerRow(username, profilePic, "submittedPic", userId);
          ll.add(w);
        }
      }
      return new Column(children: ll);
    }

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



