import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

/*
Returns Future list of [bool success, int token]
Token is used for API to find the right user
Future<bool>
*/
Future<Map> login(String username, String password) async {
  Map data = {"username": username, "password": password};
  http.Response response = await http.post(
    Uri.parse("https://hayashida.se/skillmill/api/v1/auth/login"),
    body: data,
  );
  bool success = response.statusCode == 200;
  Map convertedResponse = json.decode(response.body);
  String token = convertedResponse.values.elementAt(1);
  Map returnMessage = {"success": success, "token": token};
  return (returnMessage);
}

void testLogin(String username, String password) async {
  Map response = await login(username, password);
  print(response);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: [
          Text("Test Login"),
          Container(
            child: TextField(
              controller: usernameController,
            ),
            width: 200,
          ),
          Container(
            child: TextField(
              controller: passwordController,
            ),
            width: 200,
          ),
          Container(
            child: FloatingActionButton(
              onPressed: () {
                testLogin(usernameController.text, passwordController.text);
                print("login kört");
              },
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}
