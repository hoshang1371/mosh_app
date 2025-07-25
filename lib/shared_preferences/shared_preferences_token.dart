
//import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
//Map<String, dynamic> user = jsonDecode(jsonString);

addTokenStringToSF(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Map json = jsonDecode(token);

  // String user = jsonEncode(UserModel.fromJson(json));
  prefs.setString("token", jsonEncode(token));
  //prefs.setString('stringValue', token);
}

Future<String> getTokenStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var myData = prefs.getString("token");
  String token ="";
  if (myData != null){
    token = jsonDecode(myData);
  }


  //String? stringValue = prefs.getString('stringValue');
  return token;
}
// getTokenStringValuesSF() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   var myData = prefs.getString("token");
//   String token = jsonDecode(myData!);

//   //String? stringValue = prefs.getString('stringValue');
//   return token;
// }

Future<int> incrementCounter() async {
  // ignore: no_leading_underscores_for_local_identifiers
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final SharedPreferences prefs = await _prefs;
  final int counter = (prefs.getInt('counter') ?? 0) + 1;

  return counter;
}
