import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skillmill_demo/loginView.dart';

class NewUserView extends StatefulWidget {
  @override
  _NewUserViewState createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> attemptRegisterAccount(
      String name, String email, String password) async {
    Map data = {"name": name, "email": email, "password": password};

    http.Response response = await http.post(
      Uri.parse('http://ptsv2.com/t/5yk6y-1618407005/post'),
      body: json.encode(data),
    );
    return (response.statusCode == 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("New User"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Welcome to SkillMill",
              style: TextStyle(color: Colors.black, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 7.5),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                  hintText: 'Enter your full name'),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 7.5, bottom: 7.5),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 7.5, bottom: 15.0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                attemptRegisterAccount(nameController.text,
                    emailController.text, passwordController.text);
              },
              child: Text(
                'Register New User',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          /*SizedBox(
              height: 70,
            ), */
          Container(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              child: Text('Already have an account? Sign in'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
