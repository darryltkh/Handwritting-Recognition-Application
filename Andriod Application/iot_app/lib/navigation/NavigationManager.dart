import 'package:flutter/material.dart';

import '../OCR/ocr_main.dart';
import '../main_page.dart';
import 'exit_app.dart';

/// All the functions listed in this page is to do page routing, to the different screens availabe.
///
/// The comments above the actual function shows where the .dart file it originates from
///
/// Author: Chew Loh Seng
///
/// Version: 1.0.0
///
/// Since: 22 March 2021
class NavigationManager {
  /// Originates from drawer.dart
  ///
  /// Argument curPage will dictate the next page the application will display.
  static void drawerPageIndex(BuildContext context, int curPage) {
    if (curPage >= 1 && curPage <= 3) {
      allNavigation(context, curPage);
    } else if (curPage == 4) {
      exitApp(context);
    }
  }

  /// Originates from any functions that requires standard page pushing.
  ///
  /// Argument curPage will dictate the next page the application will display.
  /// If the curPage falls outside the 4 pages, the caller function will need to implement separately
  static void allNavigation(BuildContext context, int curPage) {
    if (curPage == 1) {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    } else if (curPage == 2) {
      Navigator.of(context).pushReplacementNamed(OCRMain.routeName);
    }
  }
}
