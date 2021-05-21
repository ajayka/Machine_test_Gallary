// framework
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_file_utils/utils.dart';
import 'package:machine_test_gallary/screens/Photo/index.dart';



class Home extends StatefulWidget {
  Home({Key key, this.path}) : super(key: key);
  final String path;
  @override
  HomeState createState() =>
      new HomeState();
}

class HomeState extends State<Home>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    //buildImages();
 axisCount=prevCount = 5;
 focaldy = focaldx = 0;
  }
  @override
  void dispose() {
    super.dispose();
  }
int axisCount = 1;
int prevCount = 1;
double focaldx,focaldy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Gallery Page"),
           /* actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, bottom: 10.0, right: 15.0),
            child: GestureDetector(
              child: new Icon(
                Icons.search,
                color: Colors.black,
              ),
              onTap: () {
                 Navigator.push(context,new MaterialPageRoute(builder: (context)=> new FolderPickerDemo() ),);
            // buildImages();
              },
            ),
          ),
            ],*/
          ),
           body:GestureDetector(
            onScaleUpdate: (details) {
              /*print(details.focalPoint.dx);
              print(focaldx);
              print(details.focalPoint.dy);
              print(focaldy);*/
              setState(() {
                if(focaldx > details.focalPoint.dx && focaldy > details.focalPoint.dy &&  (axisCount == 3 || axisCount == 1)){
                axisCount = axisCount + 2;
                }
                if(focaldx < details.focalPoint.dx && focaldy < details.focalPoint.dy && (axisCount == 3 || axisCount == 5)){
                axisCount = axisCount - 2;
                }
              focaldx = details.focalPoint.dx;
              focaldy = details.focalPoint.dy;
              prevCount = axisCount;
              });
            },
            child: FutureBuilder(
                      future: buildImages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null ){
               return Text("No Image Data  Existed Here");
              }else{
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: axisCount,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                  ),
                  primary: false,
                  itemCount:
                      snapshot.data== null? 0 : snapshot.data.length, // equals the recents files length

                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                 Navigator.push(context,new MaterialPageRoute(builder: (context)=> new Photo(path:snapshot.data[index].path) ),);
                      },
                    child:
                    Image.file(new File(snapshot.data[index].path)),);
                  },
                );
              }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
             
               return Text("Package Failed");
            }),),
    );
  }

  Future buildImages() async {
    List<File> files = await listFiles(widget.path,
        extensions: ["png", "jpg"]);
    return files;
  }
}

