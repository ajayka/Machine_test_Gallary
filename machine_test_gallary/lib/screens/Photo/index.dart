import 'package:flutter/material.dart';
import 'dart:io';
import 'package:vector_math/vector_math_64.dart' show Vector3;


class Photo extends StatefulWidget {
  Photo({Key key, this.path}) : super(key: key);
  final String path;
  @override
  PhotoState createState() =>
      new PhotoState();
}

  double _scale = 1.0;
  double _previousScale = 1.0;

class PhotoState extends State<Photo>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text("Gallery Page"),
            actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, bottom: 10.0, right: 15.0),
            child: GestureDetector(
              child: new Text(''),
              onTap: () {
                
              },
            ),
          ),
            ],
          ),
      body: Container(
        height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
        child : GestureDetector(
    onScaleStart: (ScaleStartDetails details) {
           //print(details);
            _previousScale = _scale;
            setState(() {});
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
           // print(details);
            _scale = _previousScale * details.scale;
            setState(() {});
          },
          onScaleEnd: (ScaleEndDetails details) {
           // print(details);

            _previousScale = 1.0;
            setState(() {});
          },           
          child: 
          Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child:Image.file(new File(widget.path)),
          
        )
      ))
    );
  }
}