import 'package:flutter/material.dart';
import 'package:ecohub_app/services/auth.dart';
import 'package:ecohub_app/main.dart';
import 'package:firebase_storage/firebase_storage.dart';


class _LoginState extends State<Login> {
  String emessage = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    bool invalid()
    {
      if(emessage!="")
        return true;
      return false;
    }

    return Scaffold(

      backgroundColor: Colors.black,//Color.fromRGBO(46,139,87, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),

            child: SingleChildScrollView(
                child: Column
                  (
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>
                  [

                    SizedBox(height: 100),

//                    new Image(
//                      image: new AssetImage("assets/apple.png"),
//                      width: 100,
//                      height:  100,
//                    ),


                    SizedBox(height: 10),
                    //Text('EcoHub',style: TextStyle(fontSize: 50,color: Color.fromRGBO(42, 222, 42, 1)),),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "eco",
                            style: TextStyle(fontSize: 40,color: Colors.green),
                          ),
                          Text(
                            "hub",
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          )
                        ]
                    ),
                    Text('____________________________',style: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),),
                    SizedBox(height: 100),


                    invalid()?
                    TextField(textAlign: TextAlign.center, controller: emailController, style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
                      ),
                    ):
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

            invalid()?
            TextField(textAlign: TextAlign.center,controller: passwordController,style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
              ),
            ):
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
              obscureText: true,
            ),
            SizedBox(height: 20),

            RaisedButton(color: Color.fromRGBO(42, 222, 42, 1),
                onPressed: () async {
                  widget._login(emailController.text, passwordController.text);
                  setState(() {
                    emessage = "Invalid username or password";
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text('Login', style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            RaisedButton(color: Color.fromRGBO(42, 222, 42, 1),
                onPressed: (){
                    widget._toRegister();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text('Register', style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            SizedBox(height: 20),
            Text("$emessage")
          ],
        ),
      ),
      )
    );
  }
}



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  const Login({
    Key key,
    this.auth,
    this.title,
    @required this.myapp,
  }) : super(key: key);

  final BaseAuth auth;
  final MyAppState myapp;
  final String title;

  void _login(String email, String password) async {
    this.myapp.setLoading(true);
    String userId = await auth.signIn(email.trim(), password.trim());
    if(userId.length == 0)this.myapp.setLoading(false);
    if(userId.length > 0) {
      StorageReference ref = FirebaseStorage.instance.ref().child("images/$userId");
      String url = (await ref.getDownloadURL()).toString();
      String email = (await auth.getCurrentUser()).email;
      this.myapp.setState(() {
        myapp.userId = userId;
        myapp.authState = AuthStatus.LOGGED_IN;
        myapp.email = email;
        this.myapp.imageUrl = url;
      });
      if(url != null && email != null) {
        this.myapp.setLoading(false);
        this.myapp.changePage(PageType.DASHBOARD);
      }
    }else{

      print("Failed to login");
    }
  }



  void _toRegister(){
    this.myapp.changePage(PageType.REGISTER);
  }
}