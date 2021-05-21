import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:skillmill_demo/loginView.dart';
import 'package:skillmill_demo/objects/API-communication.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'objects/globals.dart' as globals;

class NewUserView extends StatefulWidget {
  @override
  _NewUserViewState createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool error = false;
  /*
  Future<bool> attemptRegisterAccount(
      String name, String email, String password) async {
    Map data = {"name": name, "email": email, "password": password};

    http.Response response = await http.post(
      Uri.parse('http://ptsv2.com/t/5yk6y-1618407005/post'),
      body: json.encode(data),
    );
    return (response.statusCode == 200);
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: globals.themeColor,
        title: Text("Create an account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.60,
                    /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('images/skillmill_logo.png')),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Welcome to SkillMill",
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),*/
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 7.5),
              child: TextField(
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onChanged: (String s) {
                  setState(() {
                    error = false;
                  });
                },
                cursorColor: globals.themeColor,
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 0.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 0.5),
                    ),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: globals.themeColor),
                    hintText: 'Enter your new username'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 7.5, bottom: 7.5),
              child: TextField(
                onChanged: (String s) {
                  setState(() {
                    error = false;
                  });
                },
                onSubmitted: (String s) async {
                  Map response = await register(
                      usernameController.text, passwordController.text);
                  if (response.values.elementAt(0)) {
                    //success
                    globals.token = response.values.elementAt(1);
                    print('CREATED ACCOUNT SUCCESSFULLY');
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pushReplacementNamed('/home');
                    error = false;
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        title: 'Welcome to SkillMill',
                        desc:
                            'This is your home screen, here you can create your first situation',
                        btnOkOnPress: null,
                        btnOkIcon: Icons.check_circle,
                        onDissmissCallback: null)
                      ..show();
                  } else {
                    //fail
                    print('ERROR FROM API');
                    FocusScope.of(context).unfocus();
                    setState(() {
                      error = true;
                    });
                  }
                },
                obscureText: true,
                cursorColor: globals.themeColor,
                controller: passwordController,
                decoration: InputDecoration(
                    errorText: error ? "Username is taken" : null,
                    border: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 0.5),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: globals.themeColor, width: 0.5)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: globals.themeColor),
                    hintText: 'Enter a secure password'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: globals.themeColor,
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                iconSize: 35,
                icon: Icon(Icons.check, color: Colors.white),
                onPressed: () async {
                  Map response = await register(
                      usernameController.text, passwordController.text);
                  if (response.values.elementAt(0)) {
                    //success
                    globals.token = response.values.elementAt(1);
                    print('CREATED ACCOUNT SUCCESSFULLY');
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pushReplacementNamed('/home');
                    error = false;
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        title: 'Welcome to SkillMill',
                        desc:
                            'This is your home screen, here you can create your first situation',
                        btnOkOnPress: null,
                        btnOkIcon: Icons.check_circle,
                        onDissmissCallback: null)
                      ..show();
                  } else {
                    //fail
                    print('ERROR FROM API');
                    FocusScope.of(context).unfocus();
                    setState(() {
                      error = true;
                    });
                  }
                  //attemptRegisterAccount(usernameController.text,
                  //emailController.text, passwordController.text);
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text(
                  'Already have an account? Sign in',
                  style: TextStyle(color: globals.themeColor),
                ),
                onPressed: () {
                  Navigator.pop(context);

                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
