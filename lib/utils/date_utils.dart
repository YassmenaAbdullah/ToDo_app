import 'package:intl/intl.dart';

class MyDateUtils {
  static String formatTaskDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('d/M/y');
    return formatter.format(dateTime);
  }
}
extension DataTimeExtension on DateTime {
  DateTime extractDateOnly() {
    return DateTime(this.year, this.month, this.day);
  }
}
