import 'package:flutter/material.dart';

import 'NavigationManager.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            color: Colors.orange,
            child: Text(
              'Welcome to Health Zone!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
              leading: Icon(Icons.home, color: Colors.orange, size: 25),
              title: Text(
                'Home Page',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'RobotoCondensed',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                NavigationManager.drawerPageIndex(context, 1);
              }),
          ListTile(
            leading: Icon(Icons.medical_services, color: Colors.cyan, size: 22),
            title: Text(
              'OCR',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 2);
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services, color: Colors.cyan, size: 22),
            title: Text(
              'OCR Demo',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 3);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.exit_to_app, color: Colors.deepPurple, size: 20),
            title: Text(
              'Exit',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'RobotoCondensed',
                fontSize: 16,
              ),
            ),
            onTap: () {
              NavigationManager.drawerPageIndex(context, 4);
            },
          ),
        ],
      ),
    );
  }
}
