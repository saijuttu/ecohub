import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecohub_app/main.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Submit extends StatefulWidget {
  const Submit({
    Key key,
    this.auth,
    this.userId,
    this.eventId,
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
  final String userId;
  final String eventId;
  final MyAppState myapp;
  final String imgUrl, title, description, date, hours, organizer, location;

  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  Future<File> _image;

  Future getImage() async{
    Future<File> image = ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  void addUserToEvent() async{
    QuerySnapshot allDocuments = await Firestore.instance.collection("events").getDocuments();

    for(int i = 0; i< allDocuments.documents.length; i++){
      print(allDocuments.documents[i].documentID);
      print(widget.eventId);
      if(allDocuments.documents[i].documentID == widget.eventId)
      {
        String uid = widget.eventId;
        List<dynamic> userList = allDocuments.documents[i].data["userList"];
        List<dynamic> submitList = allDocuments.documents[i].data["submissionList"];
        userList.add(widget.userId);
        String submitId = "${widget.userId}-${widget.eventId}";
        submitList.add(submitId);
        await Firestore.instance.collection("events").document(uid).updateData({"userList":userList});
        await Firestore.instance.collection("events").document(uid).updateData({"submissionList":submitList});
      }
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: _image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return
            Column(children: [
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
                List data = [widget.imgUrl, widget.title, widget.description, widget.date, widget.hours, widget.organizer,widget.location,widget.eventId];
                widget.myapp.changePageWithData(PageType.EVENTVIEW,data);
              }
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              child: const Icon(Icons.send),
              onPressed: ()async{
                print("Accepted");
                File file = await _image;
                if (file==null){
                  print("No image");
                }else{
                    Uploader task = Uploader(userId: widget.userId, file: file, eventId: widget.eventId,);
                    task.startupUpload();
                    addUserToEvent();
                }
                widget.myapp.changePage(PageType.DASHBOARD);
              }
          ),
        ),
      ],

    );
  }
}

class Uploader extends StatelessWidget{
  final String userId;
  final File file;
  final String eventId;

  Uploader({Key key, this.userId, this.file, this.eventId}) : super(key: key);

  final FirebaseStorage storage = FirebaseStorage(storageBucket: "gs://ecohubfirebase.appspot.com");

  StorageUploadTask uploadTask;

  void startupUpload(){
    String filepath = 'submissions/$userId-${eventId}';
    uploadTask = storage.ref().child(filepath).putFile(file);
    if(uploadTask.isSuccessful){
      print("Sucessful upload");
    }


  }
  @override
  Widget build(BuildContext context){}


}


