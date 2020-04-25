import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class OrgDash extends StatefulWidget {
  final String userId;
  final MyAppState myapp;
  const OrgDash({
    Key key,
    this.userId,
    @required this.myapp,
  }) : super(key: key);

  void _submit(){
    this.myapp.changePage(PageType.ORGANIZE);
  }

  @override
  OrgDashState createState() => OrgDashState();
}

class OrgDashState extends State<OrgDash> {
  final formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
