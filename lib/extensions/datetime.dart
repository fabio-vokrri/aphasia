import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  DateTime apply(TimeOfDay timeOfDay) {
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}
