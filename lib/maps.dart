import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Maps extends StatefulWidget {
  final String userId;
  final MyAppState myapp;
  const Maps({
    Key key,
    this.userId,
    @required this.myapp,
  }) : super(key: key);

  void _submit(){
  }

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  final formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("NOSDOFHpoHFSDPFHFPAPOHODPS"),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed:(){
            print("update");
            widget._submit();
          }
      ),
    );
  }
}
