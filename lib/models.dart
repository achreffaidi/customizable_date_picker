import 'package:flutter/material.dart';
class Month {
  GlobalKey key;
  int numberOfDays;
  int weeksCount;
  DateTime firstDay;
  DateTime lastDay;
  List<CustomDay> days = new List();
  CustomDay Function (DateTime date) generateCustomDay;

  Month(DateTime date,{CustomDay Function (DateTime date) dayGenerator,int firstDayOfWeek = 0}) {
    key = new GlobalKey();
    generateCustomDay = dayGenerator??_defaultDayGenerator;
    firstDay = DateTime(date.year, date.month, 1);
    lastDay = DateTime(date.year, date.month + 1, 0);
    weeksCount = DateTime(date.year, date.month + 1, 0).day;
    generateDates(firstDay, lastDay,firstDayOfWeek);
    numberOfDays = days.length;
    weeksCount = numberOfDays % 7;
  }
  void generateDates(DateTime firstDay, DateTime lastDay, int firstDayOfWeek) {
    int missingDays = firstDay.weekday - 1 - firstDayOfWeek;
    DateTime currentDay = firstDay.subtract(Duration(days: missingDays));
    while (
    currentDay.isBefore(lastDay) || currentDay.isAtTheSameDayAs(lastDay)) {
      for (int i = 0; i < 7; i++) {
        var day = generateCustomDay(currentDay);
        day.hidden = currentDay.isBefore(firstDay) || currentDay.isAfter(lastDay) ;
        days.add(day);
        currentDay = currentDay.add(Duration(days: 1));
      }
    }
  }
  CustomDay _defaultDayGenerator(DateTime date) => CustomDay(date,null);
}

class CustomDay {
  DateTime date;
  dynamic data;
  bool hidden = false;
  CustomDay(this.date, this.data, {this.hidden});
}

extension NumberParsing on DateTime {
  bool isAtTheSameDayAs(DateTime x) {
    return this.day == x.day && this.month == x.month && this.year == x.year;
  }
}
