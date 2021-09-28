
import 'dart:async';

import 'package:flutter/services.dart';

class Sharedpreferences {
  static const MethodChannel _channel = MethodChannel('sharedpreferences');
  static put(String key ,dynamic value)async{
    await _channel.invokeMapMethod("put",{
      "key":key,
      "value":value
    });
  }
}
