import 'package:flutter_test/flutter_test.dart';
import 'package:screen_corners/screen_corners.dart';
import 'package:screen_corners/screen_corners_platform_interface.dart';

class _FakeScreenCornersPlatform extends ScreenCornersPlatform {
  int initCalls = 0;

  @override
  Future<CornerValue?> initScreenCorners() async {
    initCalls++;
    return CornerValue(value: 5.0);
  }

  @override
  CornerValue getValue() => CornerValue(value: 5.0);
}

void main() {
  late _FakeScreenCornersPlatform fakePlatform;
  late ScreenCornersPlatform previousPlatform;

  setUp(() {
    previousPlatform = ScreenCornersPlatform.instance;
    fakePlatform = _FakeScreenCornersPlatform();
    ScreenCornersPlatform.instance = fakePlatform;
  });

  tearDown(() {
    ScreenCornersPlatform.instance = previousPlatform;
  });

  group('ScreenCorners', () {
    group('ScreenCorners()', () {
      test('should return the same singleton instance', () {
        expect(ScreenCorners(), same(ScreenCorners()));
      });
    });

    group('initScreenCorners()', () {
      test('should delegate to the platform implementation', () async {
        final result = await ScreenCorners.initScreenCorners();
        expect(fakePlatform.initCalls, 1);
        expect(result?.value, 5.0);
      });
    });

    group('corner', () {
      test('should return the corner value of the platform', () {
        expect(ScreenCorners.corner.value, 5.0);
      });
    });

    group('cornerValue', () {
      test('should return the corner value as double', () {
        expect(ScreenCorners.cornerValue, 5.0);
      });
    });
  });
}
