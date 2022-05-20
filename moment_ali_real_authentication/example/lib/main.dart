import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:moment_ali_real_authentication/moment_ali_real_authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _code = 'code';
  @override
  void initState() {
    super.initState();
    // initPlatformState();
    MomentAliRealAuthentication.init();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await MomentAliRealAuthentication.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_code\n'),
              TextButton(onPressed: () async {
                String? a = await MomentAliRealAuthentication.goFaceRz({
                  'url':'https://openapi.alipay.com/gateway.do?alipay_sdk=alipay-sdk-php-easyalipay-20191227&app_id=2021003125655422&biz_content={++"certify_id":"21e36e67c44d9b0c715eb8ae7580dce4"}&charset=UTF-8&format=json&method=alipay.user.certify.open.certify&sign=KLR9rWqj+Ys7DNpdp9gaxWc78qkWEcsavykmoU53J0SNt6Q+P3o/Sg731nH4nVtJfJ/GVBxh65lyeJ+bwKZ7G5ZqhE6cp99d8b+xUfHUyfqCOdv4630egjBKvyoiU386PrsD8t/oJBay3RYM+iJhF9K3qMHwr9j2XsQa+54pua24H/PPlVpfM+7HEVpqv5yJcEto6+tn+iaQS/1J/zOsAnPcURhrydAUyzUQw5g473mUacTG1ZFOaeGgLfpe/ViPMrm+UNy5V8DWWM6JRqWgnhGejEuDocBmedmIpfuSEBQJ9jsLCMfp50CWQ/etg6BPcR/PQVcDTY4Cy8eaI/5kmw==&sign_type=RSA2&timestamp=2022-05-19+09:55:08&version=1.0',
                  'certify_id':'21e36e67c44d9b0c715eb8ae7580dce4'
                });
                setState(() {
                  _code = a!;
                });
              }, child: Text('获取code',)),
            ],
          ),
        ),
      ),
    );
  }
}
