import 'package:ecohub_app/services/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Eco-Hub',
        home: Wrapper(auth: Auth()));
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key key,
    this.authState,
    this.auth,
  }) : super(key: key);

  final AuthStatus authState;
  final BaseAuth auth;

  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
 AuthStatus authState = AuthStatus.NOT_DETERMINED;

  @override
  Widget build(BuildContext context) {
    print(this.authState);
    if (this.authState==AuthStatus.LOGGED_IN){
      return Profile();
    }else{
      return Scaffold(
          appBar: AppBar(
            title: Text('Eco-Hub'),
          ),
          body: Center(
              child: FlatButton(
                onPressed: () async {
                  String userId = await widget.auth.signIn("amelachuri@gmail.com", "password");
                  setState(() {
                    this.authState = AuthStatus.LOGGED_IN;
                  });
                  print("$userId");
                },
                child: Text(
                  "Log In",
                ),
              )

          )
      )
      ;
    }
  }

}

class Profile extends StatelessWidget{
  const Profile({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eco-Hub'),
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/ecohubfirebase.appspot.com/o/download.png?alt=media&token=6f1bdef9-d4bc-4b3f-b897-030efec391e1',
                  ),
                  Text('Username'),
                  Text('Score: ##'),
                  Text('Account Type')
                ]
            )

        )
    )
    ;
  }
}


