import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moment_ali_real_authentication/moment_ali_real_authentication.dart';

void main() {
  const MethodChannel channel = MethodChannel('moment_ali_real_authentication');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MomentAliRealAuthentication.platformVersion, '42');
  });
}
