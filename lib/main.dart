import 'package:flutter/material.dart';
import 'package:skillmill_demo/navigationBar.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'package:skillmill_demo/newUserView.dart';
import 'package:skillmill_demo/objects/API-communication.dart';
import 'home.dart';
import 'loginView.dart';
import 'navigationBar.dart';

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'objects/globals.dart' as globals;
import 'services/storage.dart';

Widget _defaultHome;
Socket socket;
Stream<Uint8List> socketStream;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  //Look instorage for old token
  String oldToken;
  WidgetsFlutterBinding.ensureInitialized();
  // Is there a token that is locally stored?
  if (await tokenExists()) {
    oldToken = await getStringTokenSF();
    print('old token exists');
    bool tokenIsValid = await validateToken(oldToken);
    // If yes - is it valid?
    if (tokenIsValid) {
      globals.token = oldToken;
      _defaultHome = new Home("Homepage");
    } else {
      removeToken();
      _defaultHome = new LoginView();
    }
  } else {
    print('old token does not exist');
    oldToken = '';
    bool tokenIsValid = await validateToken(globals.token);

    if (tokenIsValid) {
      _defaultHome = new Home("Homepage");
    } else {
      _defaultHome = new LoginView();
    }
  }

  print('hej');

  // Runs app and prevents user from switching oritentation
  //WidgetsFlutterBinding.ensureInitialized();
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
        '/journal': (BuildContext context) => new NewJournal(
            oldCanvasEmojis: [],
            oldCanvasColor: Colors.white,
            oldCanvasTitle: "",
            canvasID: null),
        '/login': (BuildContext context) => new LoginView(),
        '/signUp': (BuildContext context) => new NewUserView(),
      },
      // Enables switching between widgets without accesess to context
      navigatorKey: navigatorKey,
    );
  }
}
