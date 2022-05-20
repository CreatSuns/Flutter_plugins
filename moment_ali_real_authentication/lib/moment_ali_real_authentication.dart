
import 'dart:async';

import 'package:flutter/services.dart';

class MomentAliRealAuthentication {
  static const MethodChannel _channel = MethodChannel('moment_ali_real_authentication');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future init() async{
    await _channel.invokeMethod('init');
  }

  static Future<String?> get bizCode async {
    final String? bizCode = await _channel.invokeMethod('getBizCode');
    return bizCode;
  }

  static Future<String?> goFaceRz(Map<String, dynamic> map) async {
    final String? bizCode = await _channel.invokeMethod('goFaceRz', map);
    return bizCode;
  }
}
