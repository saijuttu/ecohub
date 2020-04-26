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

class LocationData{
  final String address;
  final String latitude;
  final String longitude;
  const LocationData(this.address, this.latitude, this.longitude);
}

class Maps extends StatefulWidget {
  final String userId;
  final MyAppState myapp;
  const Maps({
    Key key,
    this.userId,
    @required this.myapp,
  }) : super(key: key);

  @override
  _MapsState createState() => _MapsState();

}

class _MapsState extends State<Maps> {

  GoogleMapController mapController;

  _onMapCreated(GoogleMapController controller)
  {
    setState(() {
      mapController = controller;
      //    controller.animateCamera(cameraUpdate);

    });
  }
  Future _getLocation() async {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;

    ScreenCoordinate screenCoordinate = ScreenCoordinate(x: middleX.round(), y: middleY.round());

    LatLng middlePoint = await mapController.getLatLng(screenCoordinate);
    print(middlePoint.longitude);
    print(middlePoint.latitude);

     getUserLocation(middlePoint);
  }

  void getUserLocation(LatLng ln) async {//call this async method from whereever you need

    final coordinates = new Coordinates(ln.latitude, ln.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('ADRESSADRESSASDEAASDASDASD ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare} ADRESSADRESSASDEAASDASDASD');
    print('featurename: ${first.adminArea}, ${first.addressLine}  | ${first.featureName}');
    print("${widget.userId}");

//    DocumentReference ref = await Firestore.instance.collection("events")
//        .add({
//      'address': '${first.addressLine}',
//      'latitude': '${ln.latitude}',
//      'longitude': '${ln.longitude}'
//    });
    LocationData data = LocationData(first.addressLine, "${ln.latitude}", "${ln.longitude}");
    widget.myapp.changePageWithData(PageType.ORGANIZE, [data]);
  }
//  static GlobalKey previewContainer = new GlobalKey();
//
//  takeScreenShot() async{
//    RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
//    ui.Image image = await boundary.toImage();
//    final directory = (await getApplicationDocumentsDirectory()).path;
//    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//    Uint8List pngBytes = byteData.buffer.asUint8List();
//    print(pngBytes);
//    File imgFile =new File('$directory/screenshot.png');
//    imgFile.writeAsBytes(pngBytes);
//  }

  @override
  Widget build(BuildContext context)
  {

    return Stack(children: [
      GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(24, -110),
            zoom: 10
        ),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        compassEnabled: true,

      ),

      Positioned(
          bottom: 50,
          left: 10,
          child:
          FlatButton
            (
            child: Icon(Icons.pin_drop, color: Colors.white),
            color: Colors.green,
            onPressed: ()  async {
               await _getLocation();
            },
          )
      )
    ]);


  }
}

