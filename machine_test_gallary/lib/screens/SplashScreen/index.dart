import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  SplashScreenstate createState() => new SplashScreenstate();
}

class SplashScreenstate extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirect();

  }
  redirect() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
     PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
      Navigator.of(context).pushReplacementNamed("/folderdemo");
      }
    } else {
     Navigator.of(context).pushReplacementNamed("/folderdemo");
    }
    
            
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
              //image: new ExactAssetImage('assets/splash_screen.jpg'),
              image:ExactAssetImage('assets/logo.png'),
              fit: BoxFit.cover
            )),
        child: new Align(
            alignment: Alignment.bottomCenter,
            child: new Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: new CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black38),
              ),
            )),
      ),
    );
  }
}
