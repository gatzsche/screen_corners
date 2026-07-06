import 'package:flutter_test/flutter_test.dart';
import 'package:screen_corners/screen_corners_method_channel.dart';
import 'package:screen_corners/screen_corners_platform_interface.dart';

class _UnimplementedPlatform extends ScreenCornersPlatform {}

void main() {
  group('ScreenCornersPlatform', () {
    group('instance', () {
      test('should default to MethodChannelScreenCorners', () {
        expect(
          ScreenCornersPlatform.instance,
          isA<MethodChannelScreenCorners>(),
        );
      });

      test('should be replaceable by a platform implementation', () {
        final previous = ScreenCornersPlatform.instance;
        final replacement = _UnimplementedPlatform();

        ScreenCornersPlatform.instance = replacement;
        expect(ScreenCornersPlatform.instance, same(replacement));

        ScreenCornersPlatform.instance = previous;
      });
    });

    group('initScreenCorners()', () {
      test('should throw UnimplementedError by default', () {
        expect(
          () => _UnimplementedPlatform().initScreenCorners(),
          throwsUnimplementedError,
        );
      });
    });

    group('getValue()', () {
      test('should throw UnimplementedError by default', () {
        expect(
          () => _UnimplementedPlatform().getValue(),
          throwsUnimplementedError,
        );
      });
    });
  });

  group('CornerValue', () {
    group('value', () {
      test('should default to 0.0', () {
        expect(CornerValue().value, 0.0);
      });

      test('should return the given value', () {
        expect(CornerValue(value: 12.5).value, 12.5);
      });
    });

    group('or(other)', () {
      test('should return other when value is 0.0', () {
        expect(CornerValue().or(8.0), 8.0);
      });

      test('should return value when value is not 0.0', () {
        expect(CornerValue(value: 4.0).or(8.0), 4.0);
      });
    });

    group('toDouble()', () {
      test('should return the value as double', () {
        expect(CornerValue(value: 3.0).toDouble(), 3.0);
      });
    });

    group('toString()', () {
      test('should return the value as string', () {
        expect(CornerValue(value: 3.5).toString(), '3.5');
      });
    });

    group('toInt()', () {
      test('should return the value truncated to an int', () {
        expect(CornerValue(value: 3.7).toInt(), 3);
      });
    });

    group('arithmetic operators', () {
      final corner = CornerValue(value: 6.0);

      test('should add', () => expect(corner + 2, 8.0));
      test('should subtract', () => expect(corner - 2, 4.0));
      test('should multiply', () => expect(corner * 2, 12.0));
      test('should divide', () => expect(corner / 2, 3.0));
      test('should calculate the modulo', () => expect(corner % 4, 2.0));
      test('should divide to an integer', () => expect(corner ~/ 4, 1));
      test('should negate', () => expect(-corner, -6.0));
    });

    group('comparison operators', () {
      final corner = CornerValue(value: 6.0);

      test('should compare with <', () {
        expect(corner < 7, isTrue);
        expect(corner < 5, isFalse);
      });

      test('should compare with <=', () {
        expect(corner <= 6, isTrue);
        expect(corner <= 5, isFalse);
      });

      test('should compare with >', () {
        expect(corner > 5, isTrue);
        expect(corner > 7, isFalse);
      });

      test('should compare with >=', () {
        expect(corner >= 6, isTrue);
        expect(corner >= 7, isFalse);
      });
    });

    group('== and hashCode', () {
      test('should treat corners with the same value as equal', () {
        expect(CornerValue(value: 6.0) == CornerValue(value: 6.0), isTrue);
        expect(CornerValue(value: 6.0) == CornerValue(value: 7.0), isFalse);
        expect(
          CornerValue(value: 6.0).hashCode,
          CornerValue(value: 6.0).hashCode,
        );
      });
    });
  });
}
