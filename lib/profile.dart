import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String userId;
  const Profile({
    Key key,
    this.userId,
  }) : super(key: key);


  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final formKey= GlobalKey<FormState>();
  void _submit(){

  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return new Scaffold

      (
      body: Card(

        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        // put the actual username through hint text here
                          labelText: 'Username'

                      ),


                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        // put the actual username through hint text here
                          labelText: 'Email'
                      ),
                    ),
                    SizedBox(height: 30),
                    Text('Hours Worked',style: TextStyle(fontSize: 30,color: Color.fromRGBO(192, 192, 192, 1)),),

                    SizedBox(height: 30),


                    Text('Rank',style: TextStyle(fontSize: 30,color: Color.fromRGBO(192, 192, 192, 1)),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: _submit,
                            child: Text("Update"),

                          ),
                        ),
                      ],
                    )
                  ],
                )
            )
        ),


      ),




    );

  }
}
//import 'package:flutter/material.dart';
//
//class Profile extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//        child: new Center(
//            child: new Text('Profile Page',
//                style: new TextStyle(fontSize: 25.0, color: Colors.purple )
//            )
//        )
//    );
//  }
//}
