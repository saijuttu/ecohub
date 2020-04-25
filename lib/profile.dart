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

    return Scaffold(
      body: Container(
              child: ListView(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: Center(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 190.0,
                                height: 190.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            "https://i.imgur.com/BoN9kdC.png")
                                    )
                                )),
                          ],
                        )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child:Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(192, 192, 192, 1)
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'example@email.com',
                      style: TextStyle(
                          fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child:Text(
                      'Username',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(192, 192, 192, 1)
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'user.name',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                    child: Center(
                      child: Text(
                        '10',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Center(
                      child: Text(
                        'Total Hours',
                        style: TextStyle(
                          fontSize: 20,
                            color: Color.fromRGBO(192, 192, 192, 1)
                        ),
                      ),
                    ),
                  ),
                ],
              )
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed:(){
            print("update");
            _submit();
          }
      ),
    );

  }
}
