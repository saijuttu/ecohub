import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return Scaffold
      ( backgroundColor: Color.fromRGBO(44, 47, 51, 1),
      body: Center
        (

        child: Column
          (
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>
          [
            Text('EcoHub',style: TextStyle(fontSize: 50,color: Color.fromRGBO(42, 222, 42, 1)),),
            Text('____________________________',style: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),),
            SizedBox(height: 100),

            TextField(textAlign: TextAlign.center, controller: emailController, style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  hintText: 'Email',
                hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
              ),
            ),
            SizedBox(height: 10),

            TextField(textAlign: TextAlign.center,controller: passwordController,style: new TextStyle(fontSize: 25,color: Color.fromRGBO(42, 222, 42, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color.fromRGBO(42, 222, 42, 1)),
              ),
            ),
            SizedBox(height: 10),

            RaisedButton(color: Color.fromRGBO(42, 222, 42, 1),
              onPressed: () {},
              child: const Text('Login', style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
