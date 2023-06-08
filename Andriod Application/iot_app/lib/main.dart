import 'dart:ui';
import 'package:flutter/material.dart';

import './OCR/ocr_main.dart';
import 'main_page.dart';

/// Contains the void main() function, which is the entry point when the application is opened.
///
/// When initialising, the third party widgets are required to be initialised as well, to make sure app reliability.
/// Therefore, the main function will start running MyApp class.
/// The MyApp class will create the system theme for the application, and sets up all the routes required for the other screens.
/// It will enter the LockScreen class (initialRoute: '/root'), at LockScreen.dart, after initialisation is complete.
///
/// Author: Chew Loh Seng
///
/// Version: 1.0.0
///
/// Since: 10 March 2021

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Health Zone',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.teal,
          canvasColor: Colors.white,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(10, 21, 21, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(10, 21, 21, 1),
            ),
            headline6: TextStyle(
              fontSize: 21,
              fontFamily: 'RobotoCondensed',
            ),
          ),
        ),
        initialRoute: '/root',
        routes: {
          OCRMain.routeName: (context) => OCRMain(),
        },
      );
  }
}
