import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// import '../navigation/drawer.dart';
import 'ocr_page.dart';

class OCRMain extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = '/root';

  static final firstCamera = getCamera();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firstCamera,
      builder:
          (BuildContext context, AsyncSnapshot<CameraDescription> snapshot) {
        if (snapshot.hasData) {
          final cam = (snapshot.data)!;
          return Scaffold(
            // drawer: MainDrawer(),
            appBar: AppBar(
              title: Text(
                "Handwritting Recognition",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
            body: OCRPage(
              // Pass the appropriate camera to the TakePictureScreen widget.
              camera: cam,
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            // drawer: MainDrawer(),
            appBar: AppBar(
              title: Text(
                "error",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Future<CameraDescription> getCamera() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  return firstCamera;
}
