import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'package:skillmill_demo/home.dart';
import 'forgotPasswordView.dart';
import 'newUserView.dart';
import 'dart:convert';
import 'home.dart';
import 'objects/API-communication.dart';
import 'objects/globals.dart' as globals;
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'services/storage.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loginFail = false;

  Future<bool> attemptLogin(String username, String password) async {
    Map data = {"123": username};
    http.Response response = await http.post(
      Uri.parse('https://hayashida.se/skillmill/api/test'),
      body: data,
    );
    print(response.body.toString());
    print(response.statusCode);
    return (response.statusCode == 200);
  }

/*
  Future<bool> attemptLoginWithStoredToken() {
    String oldToken = '';
    globals.secureStorage.readSecureData('token').then((String result) {
      setState(() {
        oldToken = result;
      });
    });
    return validateToken(oldToken);
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
        title: Text(
          "SkillMill",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.4,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: SpinningWheel(
                    Image.asset('images/skillmill_logo_transparent.png'),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.4,
                    dividers: 2,
                    onUpdate: (test) {},
                    onEnd: (test) {},
                  ),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                onChanged: (String s) {
                  setState(() {
                    loginFail = false;
                  });
                },
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                cursorColor: globals.themeColor,
                controller: usernameController,
                decoration: InputDecoration(
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
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 0.5),
                    ),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: globals.themeColor),
                    hintText: 'Enter your username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onSubmitted: (String s) async {
                  FocusScope.of(context).unfocus();
                  Map response = await login(
                      usernameController.text, passwordController.text);
                  if (response.values.elementAt(0)) {
                    globals.token = response.values.elementAt(1);
                    //want to make sure there isn't an old token in storage
                    removeToken();
                    // New token is but into storage
                    print('in loginView am gonna addTokenToSF');
                    addTokenToSF(globals.token);
                    print('addedTokenToSF');
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    setState(() {
                      loginFail = true;
                    });
                  }
                },
                onChanged: (String s) {
                  setState(() {
                    loginFail = false;
                  });
                },
                cursorColor: globals.themeColor,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 2.0),
                    ),
                    errorText: loginFail
                        ? "No account matches those credentials"
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 0.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: globals.themeColor, width: 0.5),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: globals.themeColor),
                    hintText: 'Enter your password'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: globals.themeColor,
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  Map response = await login(
                      usernameController.text, passwordController.text);
                  if (response.values.elementAt(0)) {
                    //SHOULD NOW WORK FOR STUPID GREEN BUTTON
                    globals.token = response.values.elementAt(1);
                    //want to make sure there isn't an old token in storage
                    removeToken();
                    // New token is but into storage
                    print('in loginView am gonna addTokenToSF');
                    addTokenToSF(globals.token);
                    print('addedTokenToSF');
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    setState(() {
                      loginFail = true;
                    });
                  }
                },
                icon: Icon(Icons.check, color: Colors.white),
                iconSize: 35,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ForgotPasswordView()),
                );
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: globals.themeColor),
                //style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),

            /*SizedBox(
              height: 70,
            ), */
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text(
                  'New User? Create Account',
                  style: TextStyle(color: globals.themeColor),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => NewUserView()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
