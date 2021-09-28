import 'dart:async';

import 'package:flutter/services.dart';

class Sharedpreferences {
  static const MethodChannel _channel = MethodChannel('sharedpreferences');

  static put(String key, dynamic value) async {
    await _channel.invokeMapMethod("put", {"key": key, "value": value});
  }

  static createDB() async {
    await _channel.invokeMethod("createDB");
  }

  static Future<bool> insertUser(String username, String passwd, int role) async {
    return await _channel.invokeMethod(
      "insertUser",
      {
        "username": username,
        "passwd": passwd,
        "role": role,
      },
    );
  }

  static Future<bool> testUser(String username,String passwd ,int role)async{
    return await _channel.invokeMethod(
      "testUser",
      {
        "username": username,
        "passwd": passwd,
        "role": role,
      },
    );
  }
}
