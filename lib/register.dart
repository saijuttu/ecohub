
import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecohub_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title, this.auth, this.myapp}) : super(key: key);

  final Auth auth;
  final String title;
  final MyAppState myapp;

  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  Future<File> _image;

  Future getImage() async{
    Future<File> image = ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: _image,
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
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    TextEditingController usernameController = new TextEditingController();

    return Scaffold
      (
      backgroundColor: Color.fromRGBO(44, 47, 51, 1),
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
              TextField(textAlign: TextAlign.center, controller: usernameController, style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
                ),
              ),
              SizedBox(height: 20),
              TextField(textAlign: TextAlign.center, controller: emailController, style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
                ),
              ),
              SizedBox(height: 20),

              TextField(textAlign: TextAlign.center,controller: passwordController,style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
                ),
              ),
              SizedBox(height: 20),

              RaisedButton(color: Color.fromRGBO(42, 222, 42, 1),
                  onPressed: () async {
                    String userId = await widget.auth.signUp(emailController.text.trim(), passwordController.text.trim());
                    if(userId==""){
                      print("Failure");
                    }else{
                      print("Success");
                      widget.myapp.changePage(PageType.LOGIN);
                      Firestore.instance.collection('profiles').document(userId)
                          .setData({ 'username': usernameController.text, 'organizer' : false, 'score' :0, 'pic' : "" });
                    }
                  },
                  child: const Text('Register', style: TextStyle(fontSize: 20, color: Colors.white))
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
    );
  }
}