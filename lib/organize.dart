
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:ecohub_app/maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Organize extends StatefulWidget {
    final String userId;
    final MyAppState myapp;
    final LocationData eventData;
    const Organize({
      Key key,
      this.userId,
      @required this.myapp,
      this.eventData,
    }) : super(key: key);

    void _submit(){
      this.myapp.changePage(PageType.MAPS);
    }

    void _cancel(){
      this.myapp.changePage(PageType.ORGDASH);
    }
  @override
  OrganizeState createState() => OrganizeState();

}

class OrganizeState extends State<Organize> {

  Future<File> _image;
  String description;
  String hours;
  final TextEditingController hoursController = new TextEditingController();
  final TextEditingController descriptionController = new TextEditingController();

  Future getImage() async{
    Future<File> image = ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    hoursController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: _image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Column(children: [
            Image.file(
              snapshot.data,
              width: 100,
              height: 100,
            ),
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          ]);
        } else if (snapshot.error != null) {
          return   FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          );
        }
        else {
          return   FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          );
        }
      },
    );
  }

  bool keyboardOpen = false;
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold
      (
      backgroundColor: Color.fromRGBO(44, 47, 51, 1),
      //  backgroundColor: Colors.white,
      body: Padding
        (
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: SingleChildScrollView(
          child: Column
            (
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>
            [
              SizedBox(height:75),


              showImage(),

              SizedBox(height: 75),
              TextField(textAlign: TextAlign.center,keyboardType: TextInputType.number,controller: hoursController,style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Hours',
                  hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
                ),
              ),
              SizedBox(height: 20),

              FlatButton(
                onPressed:(){
                  print("update");
                  widget._submit();
                },
                color: Colors.blue,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add Map Location")
                  ],
                ),
              ),
              SizedBox(height: 20),

              TextField(textAlign: TextAlign.center, keyboardType: TextInputType.multiline,controller: descriptionController, maxLines: 4, style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: getImage,
//        tooltip: 'Pick Image',
//        child: Icon(Icons.add_a_photo),
//      ),

        floatingActionButton:
            keyboardOpen?SizedBox():
        Stack(
          children: <Widget>[

                Padding(padding: EdgeInsets.only(left: 31),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(backgroundColor: Colors.red,
                      child: Icon(Icons.cancel),
                        onPressed: (){
                          //print(hoursController.text);
                          //print(descriptionController.text);
                          widget._cancel();
                        }
                    ),
                  ),),

                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(backgroundColor: Color.fromRGBO(42, 222, 42, 1),
                    child: Icon(Icons.check),
                    //ADD FIRE BASE CODE HERE TO ADD TO DB
                    onPressed: () async {
                      //print("${widget.eventData.address}");
                          DocumentReference ref = await Firestore.instance.collection("events").add({
                              'userId': widget.userId,
                            'hours':hoursController.text,
                            'description':descriptionController.text,
                            'address': '${widget.eventData.address}',
                            'latitude': '${widget.eventData.latitude}',
                            'longitude': '${widget.eventData.longitude}'
                      });
                    }

                    ),

                ),

          ],
        )
    );
  }
}

