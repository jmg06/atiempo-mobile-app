import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('writes afternoon times the way the mockups do', () {
    expect(ClockFormatter.time(const Duration(hours: 15, minutes: 17)), '3:17 p. m.');
    expect(ClockFormatter.digits(const Duration(hours: 15, minutes: 17)), '3:17');
  });

  test('pads minutes and handles both ends of the day', () {
    expect(ClockFormatter.time(const Duration(hours: 11, minutes: 5)), '11:05 a. m.');
    expect(ClockFormatter.time(const Duration(minutes: 30)), '12:30 a. m.');
    expect(ClockFormatter.time(const Duration(hours: 12)), '12:00 p. m.');
    expect(ClockFormatter.time(const Duration(hours: 23, minutes: 30)), '11:30 p. m.');
  });
}
