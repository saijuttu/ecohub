import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Organize extends StatefulWidget {
  final String userId;
  final MyAppState myapp;
  const Organize({
    Key key,
    this.userId,
    @required this.myapp,
  }) : super(key: key);

  void _submit(){
    this.myapp.changePage(PageType.MAPS);
  }

  @override
  OrganizeState createState() => OrganizeState();
}

class OrganizeState extends State<Organize> {
  final formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("YOOOOOO"),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed:(){
            print("update");
            widget._submit();
          }
      ),
    );
  }
}
