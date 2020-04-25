
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission/permission.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecohub_app/main.dart';
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
  void _getLocation() async {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;

    ScreenCoordinate screenCoordinate = ScreenCoordinate(x: middleX.round(), y: middleY.round());

    LatLng middlePoint = await mapController.getLatLng(screenCoordinate);
    print(middlePoint.longitude);
    print(middlePoint.latitude);
  }



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
          right: 10,
          child:
          FlatButton(
            child: Icon(Icons.pin_drop, color: Colors.white),
            color: Colors.green,
            onPressed: _getLocation,
          )
      )
    ]);


  }
}

