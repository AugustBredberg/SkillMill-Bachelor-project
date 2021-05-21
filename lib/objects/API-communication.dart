import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'dart:convert';
import 'globals.dart' as globals;
import 'emojiCanvas.dart';
import 'package:unicode/unicode.dart' as unicode;
import 'movableObject.dart';

void main() => runApp(MyApp());

//Converts a color to a string in the form "0xffffff", so it can be saved in the database
String colorToString(Color color) {
  String colorString = color.toString();
  if (colorString.length != 17) {
    return "";
  }
  String colorConverted = "";
  for (int i = 6; i < colorString.length - 1; i++) {
    colorConverted += colorString[i];
  }
  return colorConverted;
}

/*
Delete a situation
Returns: bool success
*/
Future<bool> removeSituation(String token, int situationId) async {
  try {
    Map data = {"token": token, "situation_id": situationId};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/situation/remove"),
      body: json.encode(data),
    );
    bool success = response.statusCode == 200;
    return success;
  } catch (exception) {
    throw ("failed to remove situation exception");
  }
}

/*
Checks if the current token is valid.
Returns true if valid, else false
*/
Future<bool> validateToken(String token) async {
  try {
    if (token == null) {
      return false;
    }
    Map data = {"token": token};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/auth/validate"),
      body: json.encode(data),
    );
    bool success = response.statusCode == 200;
    if (success) {
      Map convertedResponse = json.decode(response.body);
      print(convertedResponse.values.elementAt(0));
    }

    return success;
  } catch (exception) {
    throw ("validateToken exception");
  }
}

/*
Call with: await login(String username, String password)
Returns a Map:
  if success: {"success": true, "token": String}
  else      : {"success": false}
Token is used for API to find the right user
Existing account: username: adam, password: 123
*/
Future<Map> login(String username, String password) async {
  try {
    Map data = {"username": username, "password": password};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/auth/login"),
      body: data,
    );
    bool success = response.statusCode == 200;
    if (success) {
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      String token = convertedResponse.values.elementAt(1);
      Map returnMessage = {"success": success, "token": token};
      return (returnMessage);
    } else {
      Map returnMessage = {"success": success};
      return returnMessage;
    }
  } catch (exception) {
    throw ("login exception");
  }
}

/*
Call with: await register(String username, String password)
Returns a Map:
  if success: {"success": true, "token": String}
  else      : {"success": false}
Token is used for API to find the right user
*/
Future<Map> register(String username, String password) async {
  try {
    Map data = {"username": username, "password": password};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/auth/register"),
      body: data,
    );
    bool success = response.statusCode == 200;
    if (success) {
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      String token = convertedResponse.values.elementAt(1);
      Map returnMessage = {"success": success, "token": token};
      return (returnMessage);
    } else {
      Map returnMessage = {"success": success};
      return returnMessage;
    }
  } catch (exception) {
    throw ("register exception");
  }
}

/*
Deactivates the active token.
Call with: await logout(String token)
Returns bool. True if statuscode==200 (success), else false
*/
Future<bool> logout(String token) async {
  try {
    Map data = {"token": token};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/auth/invalidate"),
      body: data,
    );
    return response.statusCode == 200;
  } catch (exception) {
    throw ("logout exception");
  }
}

/*
Create a new empty situation.
Call with: await createSituation(String token)
Returns Map: 
  if success : {"success": true, "situation_id": int}
  else       : {"success": false}
*/
Future<Map> createSituation(String token) async {
  try {
    Map data = {"token": token};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/situation/create"),
      body: data,
    );
    bool success = response.statusCode == 200;
    if (success) {
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      int situationId = convertedResponse.values.elementAt(1);
      Map returnMessage = {"success": success, "situation_id": situationId};
      return (returnMessage);
    } else {
      Map returnMessage = {"success": success};
      return (returnMessage);
    }
  } catch (exception) {
    throw ("validateToken exception");
  }
}

/*
Get all situation ID's for the account.
Call with: await getAllSituations(String token)
Returns Map: 
if success: {"success": true, "allSituations": List<int>}
if failure: {"success": false}
*/
Future<Map> getAllSituations(String token) async {
  try {
    Map data = {"token": token};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/situation/all"),
      body: data,
    );
    bool success = response.statusCode == 200;
    if (success && response.body != null) {
      print(response.body);
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      List allSituations = convertedResponse.values.elementAt(1);
      Map returnMessage = {"success": success, "allSituations": allSituations};
      return (returnMessage);
    } else {
      Map returnMessage = {"success": success};
      return returnMessage;
    }
  } catch (exception) {
    throw ("getAllSituations exception");
  }
}

/*
Returns the title and description of a situation.
Call with: await getSituationInfo(String token, int situationId)
Returns Map: 
  if success: {"success": true, "title": String, "description": String}
  if failure: {"success": false}
*/
Future<Map> getSituationInfo(String token, int situationId) async {
  try {
    Map data = {"token": token, "situation_id": situationId};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/situation/get_info"),
      body: json.encode(data),
    );
    bool success = response.statusCode == 200;
    if (success) {
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      String title = convertedResponse.values.elementAt(1);
      String description = convertedResponse.values.elementAt(2);
      Map returnMessage = {
        "success": success,
        "title": title,
        "description": description
      };
      return returnMessage;
    } else {
      Map returnMessage = {"success": success};
      return returnMessage;
    }
  } catch (exception) {
    throw ("getSituationInfo exception");
  }
}

//TODO: Situation ID's are to be strings?
Future<bool> setSituationInfo(
    String token, int situationId, String title, String description) async {
  //try {
  Map data = {
    "token": token,
    "situation_id": situationId,
    "title": title,
    "description": description,
  };
  http.Response response = await http.post(
    Uri.parse("https://hayashida.se/skillmill/api/v1/situation/set_info"),
    body: json.encode(data),
  );
  print("test" + json.decode(response.body).values.elementAt(0));
  print(response.statusCode);
  //print(json.decode(response.body).values.elementAt[0]);
  return response.statusCode == 200;
  //} catch (exception) {
  //  throw ("setSituationInfo exception");
  // }
}

/*Count the number of situations made by a user
Call with: await countSituation(String token)
Returns if success: {"success": true, "count": int count}
        if failure: {"success": false}
*/
Future<Map> countSituations(String token) async {
  try {
    Map data = {"token": token};
    http.Response response = await http.post(
      Uri.parse("https://hayashida.se/skillmill/api/v1/situation/count"),
      body: data,
    );
    bool success = response.statusCode == 200;
    if (success) {
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      int count = int.parse(convertedResponse.values.elementAt(1));
      Map returnMessage = {"success": success, "count": count};
      return returnMessage;
    } else {
      Map returnMessage = {"success": success};
      return returnMessage;
    }
  } catch (exception) {
    throw ("countSituations exception");
  }
}

/*
Update a canvas with its emojis and their positions
Call with: await setEmojiData(String token, int situationId, List<EmojiMetadata> emojiData)
Returns: bool success
*/
Future<bool> setEmojiData(
    String token, int situationId, List<EmojiMetadata> emojiData) async {
  try {
    List<Map> emojiDataAsList = [];
    for (int i = 0; i < emojiData.length; i++) {
      List<int> emojiCode = unicode.toRunes(emojiData[i].emoji);
      Map currentEmoji = {
        "emoji": emojiCode,
        //"emoji": emojiData[i].emoji,
        "matrixArguments": emojiData[i].matrixArguments
      };
      emojiDataAsList.add(currentEmoji);
    }
    Map data = {
      "token": (token),
      "situation_id": (situationId),
      "emoji_data": json.encode(emojiDataAsList),
    };
    print(json.encode(data));
    http.Response response = await http.post(
      Uri.parse(
          "https://hayashida.se/skillmill/api/v1/journal/emoji/set_emojis"),
      body: json.encode(data),
    );
    print("RESPONSE:   " + response.body);
    return (response.statusCode == 200);
  } catch (exception) {
    throw ("setEmojiData exception");
  }
}

/*
Converts the response to a list of EmojiMetadata.
Used only by getEmojiData.
*/
List<EmojiMetadata> createEmojiList(http.Response response) {
  try {
    if (response.body == null) {
      return [];
    }
    Map convertedResponse = json.decode(response.body);
    List<EmojiMetadata> newList = [];
    if (convertedResponse.values.elementAt(1) == null) {
      return [];
    }
    List emojiList = json.decode(convertedResponse.values.elementAt(1));
    for (int i = 0; i < emojiList.length; i++) {
      String emoji = String.fromCharCodes(
          List<int>.from(emojiList[i].values.elementAt(0)));
      List matrixArguments = emojiList[i].values.elementAt(1);
      List matrixArgumentsConverted = List<double>.from(matrixArguments);
      print(emoji);
      print(matrixArgumentsConverted);
      EmojiMetadata emojiData = new EmojiMetadata(emoji,
          matrixArgumentsConverted, new GlobalKey<MoveableStackItemState>());
      newList.add(emojiData);
    }
    return newList;
  } catch (exception) {
    throw ("createEmojiList exception");
  }
}

/*
Fetches the emoji/text data from the server for the canvas.
Returns: {"success": bool, "emojis": [emojiMetaData]}
*/
Future<Map> getEmojiData(String token, int situationId) async {
  try {
    Map data = {"token": token, "situation_id": situationId};
    http.Response response = await http.post(
      Uri.parse(
          "https://hayashida.se/skillmill/api/v1/journal/emoji/get_emojis"),
      body: json.encode(data),
    );
    bool success = response.statusCode == 200;
    if (success) {
      List newList = createEmojiList(response);
      return {"success": success, "emojis": newList};
    } else {
      return {"success": success};
    }
  } catch (exception) {
    throw ("getEmojiData exception");
  }
}

/*
Sets the background color of a canvas
Call with: await getCanvasColor(String token, int situationId)
Returns bool success
*/
Future<bool> setCanvasColor(String token, int situationId, Color color) async {
  try {
    String colorString = colorToString(color);
    print(colorString);
    Map data = {
      "token": token,
      "situation_id": situationId,
      "color": colorString
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://hayashida.se/skillmill/api/v1/journal/emoji/set_color"),
      body: json.encode(data),
    );
    bool success = response.statusCode == 200;
    return success;
  } catch (exception) {
    throw ("setColor exception");
  }
}

/*
Gets the background color of a canvas
Call with: await getCanvasColor(String token, int situationId)
Returns if success: {"success": true, "color": Color color}
        if failure: {"success": false}
*/
Future<Map> getCanvasColor(String token, int situationId) async {
  try {
    Map data = {"token": token, "situation_id": situationId};
    http.Response response = await http.post(
      Uri.parse(
          "https://hayashida.se/skillmill/api/v1/journal/emoji/get_color"),
      body: json.encode(data),
    );
    bool success = response.statusCode == 200;
    if (success && response.body != null) {
      Map<String, dynamic> convertedResponse = json.decode(response.body);
      String colorString = convertedResponse.values.elementAt(1);
      Color color = new Color(int.parse(colorString));
      Map returnMessage = {"success": success, "color": color};
      return returnMessage;
    } else {
      return {"success": success};
    }
  } catch (exception) {
    throw ("getColor exception");
  }
}

//////////////////////Testar API-funktioner///////////////////////////////////

void testLogin(String username, String password) async {
  Map response = await login(username, password);
  print(response);
  globals.token = response.values.elementAt(1);
}

void testLogout(String token) async {
  bool response = await logout(token);
  print(response.toString());
  globals.token = null;
}

void testNewSituation(String token) async {
  Map response = await createSituation(token);
  print(response.toString());
}

void testAllSituation(String token) async {
  Map response = await getAllSituations(token);
  print(response.toString());
}

void testGetSituationInfo(String token, int situationId) async {
  Map response = await getSituationInfo(token, situationId);
  print(response);
}

void testSetSituationInfo(
    String token, int situationId, String title, String description) async {
  bool response =
      await setSituationInfo(token, situationId, title, description);
  print(response.toString());
}

void testCountSituations(String token) async {
  Map response = await countSituations(token);
  print(response);
}

void testSetEmojiData(
    String token, int situationId, List<EmojiMetadata> emojiData) async {
  bool response = await setEmojiData(token, situationId, emojiData);
  print(response.toString());
}

void testGetEmojiData(String token, int situationId) async {
  Map response = await getEmojiData(token, situationId);
  print(response);
}

void testSetColor(String token, int situationId, Color color) async {
  bool success = await setCanvasColor(token, situationId, color);
  print(success);
}

void testGetColor(String token, int situationId) async {
  Map response = await getCanvasColor(token, situationId);
  print(response.values.elementAt(1) == Colors.white);
}

void testValidate(String token) async {
  bool success = await validateToken(token);
  print(success);
}

void testRemove(String token) async {
  Map response = await createSituation(token);
  int situationId = response.values.elementAt(1);
  bool success = await removeSituation(token, situationId);
  print("Remove:  " + success.toString());
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
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final situationController = TextEditingController();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                child: Text("Login"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  testLogout(globals.token);
                },
                child: Text("Logout"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testNewSituation(globals.token);
                },
                child: Text("New situation"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testAllSituation(globals.token);
                },
                child: Text("All situations"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testGetSituationInfo(globals.token, 59);
                },
                child: Text("GetSituationInfo 59"),
              ),
            ),
            Text("Test set situation"),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: titleController,
              ),
              width: 200,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                controller: descriptionController,
              ),
              width: 200,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Situation ID",
                ),
                controller: situationController,
              ),
              width: 200,
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {
                  testSetSituationInfo(
                      globals.token,
                      int.parse(situationController.text),
                      titleController.text,
                      descriptionController.text);
                },
                child: Text("Set"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testCountSituations(globals.token);
                },
                child: Text("Count situations"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testSetEmojiData(globals.token, 59, globals.globalEmojiList1);
                },
                child: Text("setEmojiData"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testGetEmojiData(globals.token, 59);
                },
                child: Text("getEmojiData"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testSetColor(globals.token, 59, Colors.white);
                },
                child: Text("setColor"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testGetColor(globals.token, 59);
                },
                child: Text("getColor"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testValidate(globals.token);
                },
                child: Text("validate"),
              ),
            ),
            Container(
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(),
                onPressed: () {
                  testRemove(globals.token);
                },
                child: Text("TestRemove"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
