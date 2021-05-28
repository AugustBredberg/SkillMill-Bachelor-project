import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addTokenToSF(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(token);
  prefs.setString('token', token);
  print('token was added');
}

Future<String> getStringTokenSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token') ?? 'no_token_in_storage';

  print('get string token from storage');

  return stringValue;
}

// int intValue= await prefs.getInt('intValue') ?? 0

//Removes token from storage
void removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove('token');
  print('remove token from storage');
}

//Returns true if a token exists in
Future<bool> tokenExists() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey('token');

  print('checking if token exists');

  return checkValue;
}
