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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecohub_app/main.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EventView extends StatefulWidget {
  const EventView({
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
    @required this.myapp,
 //   @required this.userList,
    @required this.eventId,
  }) : super(key: key);

  final BaseAuth auth;
  final MyAppState myapp;
  final String userId;
  final String imgUrl, title, description, date, hours, organizer, location, eventId;

  @override
  EventViewState createState() => EventViewState();
}

class EventViewState extends State<EventView>
{
  EventViewState()
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

  String getLat()
  {
    if(events!=null) {
      for (int x = 0; x < events.documents.length; x++) {
        if (events.documents[x].documentID == widget.eventId)
          return events.documents[x].data["latitude"];
      }
    }
    return "";
  }
  String getLong()
  {
    if(events!=null) {
      for (int x = 0; x < events.documents.length; x++) {
        if (events.documents[x].documentID == widget.eventId)
          return events.documents[x].data["longitude"];
      }
    }
    return "";
  }
  @override
  Widget build(BuildContext context) {
    //print("URL: ${this.imgUrl}");
    void getUserLocation() async {//call this async method from whereever you need

      final coordinates = new Coordinates(29.791081, -95.808231);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      //print('ADRESSADRESSASDEAASDASDASD ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare} ADRESSADRESSASDEAASDASDASD');
      //   return first;
    }
    getUserLocation();
//    _getLocation() async
//    {
//      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//      debugPrint('location: ${position.latitude}');
//      final coordinates = new Coordinates(position.latitude, position.longitude);
//      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//      var first = addresses.first;
//      print("${first.featureName} : ${first.addressLine}");
//    }
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
                      style: TextStyle(fontSize: 27,color: Colors.white),
                    )
                  ]
              )
          ),
          body: Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)
                  )
              ),
//              color: Colors.white,

              child: Padding(
              padding: EdgeInsets.symmetric(horizontal:0, vertical:0),
                child: ListView(

//            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                        'LOCATION',
                        style: TextStyle(
                            fontSize: 20,

                            color: Color.fromRGBO(192, 192, 192, 1)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
                      child: Text(
                        '${this.widget.location}\nCoordinates: '+getLat()+', '+getLong(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 200,
                      child:  GoogleMap(
                        initialCameraPosition: CameraPosition(

                            target: LatLng(double.parse(getLat()), double.parse(getLong())),
                            zoom: 10
                        ),
                        myLocationEnabled: true,
                        compassEnabled: true,

                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
              child: const Icon(Icons.cancel),
              onPressed: (){
                print("Cancel");
                widget.myapp.changePage(PageType.DASHBOARD);
              }
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: (){

                List data = [this.widget.imgUrl, this.widget.title, this.widget.description, this.widget.date, this.widget.hours, this.widget.organizer,this.widget.location,this.widget.eventId];

                widget.myapp.changePageWithData(PageType.SUBMIT,data);
              }
          ),
        ),
      ],
    );
  }
}
