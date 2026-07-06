import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screen_corners/screen_corners_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannelScreenCorners platform;

  void mockMethodChannel(Future<Object?>? Function(MethodCall call) handler) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(platform.methodChannel, handler);
  }

  setUp(() {
    platform = MethodChannelScreenCorners();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(platform.methodChannel, null);
  });

  group('MethodChannelScreenCorners', () {
    group('initScreenCorners()', () {
      test('should read the corner value from the method channel', () async {
        final calls = <MethodCall>[];
        mockMethodChannel((call) async {
          calls.add(call);
          return 42.0;
        });

        final result = await platform.initScreenCorners();

        expect(calls, hasLength(1));
        expect(calls.first.method, 'getScreenCorners');
        expect(result?.value, 42.0);
      });

      test('should return the last value when the channel throws', () async {
        mockMethodChannel(
          (call) async => throw PlatformException(code: 'error'),
        );

        final result = await platform.initScreenCorners();
        expect(result?.value, 0.0);
      });
    });

    group('getValue()', () {
      test('should return the last read corner value', () async {
        expect(platform.getValue().value, 0.0);

        mockMethodChannel((call) async => 24.0);
        await platform.initScreenCorners();

        expect(platform.getValue().value, 24.0);
      });
    });
  });
}
