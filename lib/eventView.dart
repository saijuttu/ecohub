import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/main.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
class EventView extends StatelessWidget {
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
  }) : super(key: key);

  final BaseAuth auth;
  final MyAppState myapp;
  final String userId;
  final String imgUrl, title, description, date, hours, organizer, location;



  @override
  Widget build(BuildContext context) {
    print("URL: ${this.imgUrl}");
    void getUserLocation() async {//call this async method from whereever you need

      final coordinates = new Coordinates(29.791081, -95.808231);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print('ADRESSADRESSASDEAASDASDASD ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare} ADRESSADRESSASDEAASDASDASD');
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
          body: ListView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child:  Image(
                        image: NetworkImage(this.imgUrl),
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
                        this.title!=null?this.title:"Event Name",
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
                    this.hours!=null?this.hours:"#",
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
                  this.description!=null?this.description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
            ],
          ),

        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
              child: const Icon(Icons.cancel),
              onPressed: (){
                print("Cancel");
                myapp.changePage(PageType.DASHBOARD);
              }
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: (){
                print("Accepted");
                myapp.changePage(PageType.SUBMIT);
              }
          ),
        ),
      ],
    );
  }
}
