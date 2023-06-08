import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayResultScreen extends StatefulWidget {
  final String imagePath;

  const DisplayResultScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayResultScreen> createState() => _DisplayResultScreenState();
}

class _DisplayResultScreenState extends State<DisplayResultScreen> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 5),
        () => 'Data Loaded',
  );

  Future<String> remoteML(File selectedImage) async {
    var url = Uri.parse('http://34.171.87.77/upload');

    final request = http.MultipartRequest("POST", url);
    final headers = {"Content-type": "multipath/form-data"};

    request.files.add(
      http.MultipartFile('image', selectedImage.readAsBytes().asStream(),
          selectedImage.lengthSync(),
          filename: selectedImage.path.split('/').last),
    );

    request.headers.addAll(headers);
    print("Request: " + request.toString());

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    print('Response status: ${res.statusCode}');
    if (res.statusCode == 201 || res.statusCode == 200) {
      print("POST OK");
      print(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      return jsonData['result'];
    } else {
      var errorCode = res.statusCode;
      var errorText = res.body;
      print(errorCode);
      print(errorText);
      throw Exception('Failed to Load Prediction!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: _calculation,
      future: remoteML(File(widget.imagePath)),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(flex:1, child: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            ),
            Expanded(flex:1, child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Image.file(File(widget.imagePath)),
            ),),
            Expanded(flex:1, child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Result: ${snapshot.data}'),
            ),),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Result')),
          resizeToAvoidBottomInset: false,
          // The image is stored as a file on the device. Use the `Image.file`
          // constructor with the given path to display the image.
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
