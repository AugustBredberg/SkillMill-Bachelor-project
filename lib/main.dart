import 'package:flutter/material.dart';
import 'package:skillmill_demo/navigationBar.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'package:skillmill_demo/newUserView.dart';
import 'loginView.dart';
import 'navigationBar.dart';

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

Widget _defaultHome;
Socket socket;
Stream<Uint8List> socketStream;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  // Connection to the server
  // Sets the startwidget
  _defaultHome = new LoginView();

  // Runs app and prevents user from switching oritentation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App',
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        // Set named routes for using the Navigator.
        '/home': (BuildContext context) => new NavigationBar(),
        '/journal': (BuildContext context) => new NewJournal(oldCanvasEmojis: [], oldCanvasColor: Colors.white),
        '/login': (BuildContext context) => new LoginView(),
        '/signUp': (BuildContext context) => new NewUserView(),
      },
      // Enables switching between widgets without accesess to context
      navigatorKey: navigatorKey,
    );
  }
}
