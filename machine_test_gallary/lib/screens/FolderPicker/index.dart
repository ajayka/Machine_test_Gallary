import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
import 'package:folder_picker/folder_picker.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_gallary/screens/Home/index.dart';

class _FolderPickerDemoState extends State<FolderPickerDemo> {
  Directory externalDirectory;
  Directory pickedDirectory;

  Future<void> getPermissions() async {
    final permissions =
    await Permission.getPermissionsStatus([PermissionName.Storage]);
    var request = true;
    switch (permissions[0].permissionStatus) {
      case PermissionStatus.allow:
        request = false;
        break;
      case PermissionStatus.always:
        request = false;
        break;
      default:
    }
    if (request) {
      await Permission.requestPermissions([PermissionName.Storage]);
    }
  }

  Future<void> getStorage() async {
    final directory = await getExternalStorageDirectory();
    setState(() => externalDirectory = directory);
  }

  Future<void> init() async {
    await getPermissions();
    await getStorage();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    print(externalDirectory.toString());
    return Scaffold(
        body: Center(
            child: (externalDirectory != null)
                ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child:Container(
                     color: Colors.lightBlueAccent,
                     height: 45,
                     width:150,
                      child:Center( child:const Text("Pick a folder", textScaleFactor: 1.3)),
                    ),
                    onTap: () => Navigator.of(context)
                        .push<FolderPickerPage>(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FolderPickerPage(
                              rootDirectory: new Directory("/storage/emulated/0"),
                              action: (BuildContext context,
                                  Directory folder) async {
                                print("Picked directory $folder");
                                setState(() => pickedDirectory = folder);
                                Navigator.of(context).pop();
                              });
                        })),
                  ),
                  (pickedDirectory != null)
                      ? Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text("${pickedDirectory.path}"),
                  )
                      : const Text(''),
                    pickedDirectory == null ?Container(): GestureDetector(
              child: new Padding(padding:EdgeInsets.fromLTRB(20, 20, 10, 0),
              child:Container(
                height: 30,
                              child: Center (child: Text("Show data In above path",style: new TextStyle(
                                color: Colors.black,)),),
                              color: Colors.grey,
                             
                            ),),
              onTap: () {
                 Navigator.push(context,new MaterialPageRoute(builder: (context)=> new Home(path:pickedDirectory.path) ),);
            // 
              },
            )
                ])
                : const CircularProgressIndicator()));
  }
}

class FolderPickerDemo extends StatefulWidget {
  @override
  _FolderPickerDemoState createState() => _FolderPickerDemoState();
}