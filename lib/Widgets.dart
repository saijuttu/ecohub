import 'package:flutter/material.dart';

class Texty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(child: new Text('this words'));
  }
}

class MyExploreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/apple.png');
    var image = new Image(image: assetsImage,width: 314.0,height: 305.0,);
    return new Container(child: image);
  }
}
