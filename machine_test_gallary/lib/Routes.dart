import 'package:machine_test_gallary/screens/Home/index.dart';
import 'package:machine_test_gallary/screens/FolderPicker/index.dart';

import 'package:flutter/material.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    "/folderdemo": (BuildContext context) => new FolderPickerDemo(),
    };

  Routes() {
    runApp(new MaterialApp(
      title: "test",
      debugShowCheckedModeBanner: false,
      //home: new Home(),
      home: new FolderPickerDemo(),
     // theme: appTheme,
      routes: routes,
    ));
  }
}
