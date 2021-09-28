import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharedpreferences/sharedpreferences.dart';

void main() {
  const MethodChannel channel = MethodChannel('sharedpreferences');

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
    expect(await Sharedpreferences.platformVersion, '42');
  });
}
