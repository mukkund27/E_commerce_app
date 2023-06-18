

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

 static Future<void> saveUserDetails(String email, String password)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString("email", email);
    await preferences.setString("password", password);
    log("Details saved!");

  }

  static Future<Map<String,dynamic>> fetchUSerDetails()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? email=preferences.getString("email");
    String? password=preferences.getString("password");
 return {
   "email":email,
   "password":password
 };
 }

 static Future<void> clear()async{
   SharedPreferences preferences=await SharedPreferences.getInstance();
   await preferences.clear();
 }
}