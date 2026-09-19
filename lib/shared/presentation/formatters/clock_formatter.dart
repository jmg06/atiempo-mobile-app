abstract final class ClockFormatter {
  /// `3:17 p. m.`
  static String time(Duration sinceMidnight) {
    final int hours = sinceMidnight.inHours % Duration.hoursPerDay;
    final String meridiem = hours < 12 ? 'a. m.' : 'p. m.';
    return '${digits(sinceMidnight)} $meridiem';
  }

  /// `3:17`, as a lock-screen clock shows it.
  static String digits(Duration sinceMidnight) {
    final int hours = sinceMidnight.inHours % Duration.hoursPerDay;
    final int twelveHour = hours % 12 == 0 ? 12 : hours % 12;
    final String minutes = (sinceMidnight.inMinutes % Duration.minutesPerHour).toString().padLeft(2, '0');
    return '$twelveHour:$minutes';
  }
}
