import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecohub_app/main.dart';
import 'dart:typed_data';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
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

  void backToOrganize()
  {
    this.myapp.changePage(PageType.ORGANIZE);
  }

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
    takeScreenShot();
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
  double middleX()
  {
    double screenWidth = MediaQuery.of(context).size.width;
    double middleX = screenWidth / 2;
    return middleX;
  }
  double middleY()
  {
    double screenHeight = MediaQuery.of(context).size.height;
    double middleY = screenHeight / 2;
    return middleY;
  }

  void getUserLocation(LatLng ln) async {//call this async method from whereever you need

    final coordinates = new Coordinates(ln.latitude, ln.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('ADRESSADRESSASDEAASDASDASD ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare} ADRESSADRESSASDEAASDASDASD');
    //   return first;
  }
//  static GlobalKey previewContainer = new GlobalKey();
//
  void takeScreenShot() async{

    RenderRepaintBoundary boundary = screen.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    var filePath = await ImagePickerSaver.saveFile(
        fileData: pngBytes);
    print(filePath);
   // var savedFile= File.fromUri(Uri.file(filePath));

  }
 // GlobalKey rootWidgetKey = GlobalKey();

 // List<Uint8List> images = List();

//  _capturePng() async {
//    try {
//      RenderRepaintBoundary boundary =
//      rootWidgetKey.currentContext.findRenderObject();
//      var image = await boundary.toImage(pixelRatio: 3.0);
//      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//      Uint8List pngBytes = byteData.buffer.asUint8List();
//      images.add(pngBytes);
//      setState(() {});
//      return pngBytes;
//    } catch (e) {
//      print(e);
//    }
//    return null;
//  }


  static GlobalKey screen = new GlobalKey();

  @override
  Widget build(BuildContext context)
  {

    return new Scaffold(

      body: RepaintBoundary(
        key: screen,
      child: Stack(
        children: [
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
            onPressed: (){_getLocation();},
          )
      )
    ])
      )
    );


  }
}

