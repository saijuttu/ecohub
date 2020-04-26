import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecohub_app/main.dart';
import 'dart:io';

class Submit extends StatefulWidget {
  const Submit({
    Key key,
    this.auth,
    this.userId,
    @required this.myapp,
  }) : super(key: key);

  final BaseAuth auth;
  final String userId;
  final MyAppState myapp;

  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  Future<File> image;
  Future getImage() async{
    Future<File> image = ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      image = image;
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 100,
            height: 100,
          );
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

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: <Widget>[
        Scaffold(
          body: Center(
            child: showImage(),
          )
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
              child: const Icon(Icons.cancel),
              onPressed: (){
                print("Cancel");
                widget.myapp.changePage(PageType.EVENTVIEW);
              }
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              child: const Icon(Icons.send),
              onPressed: (){
                print("Accepted");
                widget.myapp.changePage(PageType.DASHBOARD);
              }
          ),
        ),
      ],

    );
  }
}
