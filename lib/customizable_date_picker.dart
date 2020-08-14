library customizable_date_picker;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';

class CustomDatePicker extends StatefulWidget {
  final CustomDatePickerController controller;
  final TextStyle activeDayTextStyle;
  final TextStyle hiddenDayTextStyle;
  final TextStyle headerTextStyle;
  final Color selectedDaysColor;
  final Color headerBackgroundColor;
  final List<String> daysOfWeek;
  final Widget background;
  final Widget Function(CustomDay day, int index) dayItemBuilder;
  final Widget Function(DateTime date) monthTitleBuilder;

  CustomDatePicker(this.controller,
      {this.activeDayTextStyle = const TextStyle(fontWeight: FontWeight.w700),
      this.hiddenDayTextStyle = const TextStyle(fontWeight: FontWeight.w300),
      this.headerTextStyle = const TextStyle(fontWeight: FontWeight.w700),
      this.selectedDaysColor = Colors.blue,
      this.headerBackgroundColor = Colors.white,
      this.daysOfWeek = const ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"],
      this.background,
      this.dayItemBuilder,
      this.monthTitleBuilder});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime firstDate;
  DateTime lastDate;
  Widget Function(CustomDay day, int index) dayItemBuilder;
  Widget Function(DateTime date) monthTitleBuilder;
  Key headerKey = UniqueKey();
  bool isScrolling = false;
  bool changeFirst = false;

  @override
  void initState() {
    dayItemBuilder = widget.dayItemBuilder ?? _defaultDayItemBuilder;
    monthTitleBuilder = widget.monthTitleBuilder ?? _defaultMonthHeaderBuilder;
    controller = widget.controller;
    if (controller != null) controller.datePicker = this;
    super.initState();
  }

  ScrollController scrollingController = new ScrollController();
  CustomDatePickerController controller;

  @override
  Widget build(BuildContext context) {
    Duration animationDuration = Duration(milliseconds: 200);
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: widget.background ?? Container(),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                isScrolling = true;
                setState(() {});
              } else if (scrollNotification is ScrollEndNotification) {
                isScrolling = false;
                setState(() {});
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: scrollingController,
              child: Container(
                child: Column(
                  children: <Widget>[
                        SizedBox(height: 50),
                      ] +
                      controller._months
                          .map((e) => _getMonthWidget(e, []))
                          .toList(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            top: isScrolling ? -70 : 0,
            left: 0,
            right: 0,
            child: _getDaysOfWeekWidget(),
            duration: animationDuration,
          ),
        ],
      ),
    );
  }

  Widget _getMonthWidget(Month month, List<CustomDay> list) {
    return Column(
      key: month.key,
      children: <Widget>[
        monthTitleBuilder(month.firstDay),
        _getMonthBodyWidget(month, list)
      ],
    );
  }

  Widget _defaultMonthHeaderBuilder(DateTime date) {
    final f = new DateFormat('MMMM, yyyy');
    String formattedText = f.format(date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 15, top: 30),
            child: Text(
              formattedText,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            )),
      ],
    );
  }

  Widget _getMonthBodyWidget(Month month, List<CustomDay> list) {
    List<Widget> rows = new List();
    for (int i = 0; i < month.numberOfDays / 7; i++) {
      List<Widget> row = new List();
      for (int j = 0; j < 7; j++) {
        row.add(dayItemBuilder(month.days[j + i * 7], j + i * 7));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: row,
      ));
    }
    return Container(
        child: Column(
      children: rows,
    ));
  }

  Widget _defaultDayItemBuilder(CustomDay day, int index) {
    bool isSelected = false;
    if (firstDate != null && !day.hidden) {
      if (day.date.isAtTheSameDayAs(firstDate)) {
        isSelected = true;
      } else {
        if (lastDate != null && day.date.isAfter(firstDate)) {
          if (day.date.isBefore(lastDate) ||
              day.date.isAtTheSameDayAs(lastDate)) {
            isSelected = true;
          }
        }
      }
    }
    var br;
    if (isSelected) {
      if (firstDate.isAtTheSameDayAs(lastDate)) {
        br = BorderRadius.circular(25);
      } else if (day.date.isAtTheSameDayAs(firstDate)) {
        br = BorderRadius.only(
            topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0));
      } else if (day.date.isAtTheSameDayAs(lastDate)) {
        br = BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0));
      } else {
        br = BorderRadius.only();
      }
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectDate(day.date);
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: br),
          height: 50,
          child: Center(
              child: Container(
                  child: Text(
            day.date.day.toString(),
            style: day.hidden
                ? widget.hiddenDayTextStyle
                : widget.activeDayTextStyle,
          ))),
        ),
      ),
    );
  }

  Widget _getDaysOfWeekWidget() {
    return Container(
      color: widget.headerBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.daysOfWeek
                  .map((e) => Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        e,
                        style: widget.headerTextStyle,
                      ))))
                  .toList()),
        ),
      ),
    );
  }

  void selectDate(DateTime date) {
    if (firstDate == null) {
      firstDate = date;
      lastDate = date;
    } else {
      if (date.isAtTheSameDayAs(firstDate) || date.isAtTheSameDayAs(lastDate)) {
        firstDate = date;
        lastDate = date;
      } else if (date.isAfter(lastDate)) {
        lastDate = date;
      } else if (date.isBefore(firstDate)) {
        firstDate = date;
      } else {
        if (changeFirst)
          firstDate = date;
        else
          lastDate = date;
        changeFirst = !changeFirst;
      }
    }
    if (controller != null && controller.onRangeSelected != null) {
      controller.onRangeSelected(firstDate, lastDate);
    }
  }

  void removeSelect() {
    firstDate = null;
    lastDate = null;
    controller.onRangeSelected(firstDate, lastDate);
  }

  void notify() {
    setState(() {});
  }
}

class CustomDatePickerController {
  CustomDay Function(DateTime date) generateCustomDay;
  List<Month> _months;
  List<CustomDay> listOfDays = List();
  _CustomDatePickerState datePicker;
  Function(DateTime firstDate, DateTime lastDate) onRangeSelected;
  CustomDatePickerController(
      {DateTime start, DateTime end, this.generateCustomDay}) {
    if (start == null || end == null || start.isAfter(end)) {
      start = DateTime.now();
      end = start.add(Duration(days: 370));
    }
    _months = new List();
    while (start.isBefore(end)) {
      start = DateTime(start.year, start.month);
      _months.add(Month(start, dayGenerator: generateCustomDay));
      start = start.add(Duration(days: 33));
    }
  }

  void onDaySelect(DateTime dateTime) {
    datePicker.selectDate(dateTime);
  }

  void scrollTo(DateTime date) {
    for (Month month in _months) {
      if (date.year == month.firstDay.year &&
          date.month == month.firstDay.month) {
        try {
          Scrollable.ensureVisible(month.key.currentContext,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn);
        } catch (e) {
          //TODO handle Exception
        }
        break;
      }
    }
  }

  List<CustomDay> getListOfSelectedDays() {
    var list = new List<CustomDay>();
    for (Month month in _months) {
      for (CustomDay day in month.days) {
        bool isSelected = false;
        if (datePicker.firstDate != null && !day.hidden) {
          if (day.date.isAtTheSameDayAs(datePicker.firstDate)) {
            isSelected = true;
          } else {
            if (datePicker.lastDate != null &&
                day.date.isAfter(datePicker.firstDate)) {
              if (day.date.isBefore(datePicker.lastDate) ||
                  day.date.isAtTheSameDayAs(datePicker.lastDate)) {
                isSelected = true;
              }
            }
          }
        }
        if (isSelected) list.add(day);
      }
    }
    return list;
  }

  void removeSelect() {
    datePicker.removeSelect();
  }

  bool setDayData(DateTime date, dynamic data) {
    for (Month month in _months) {
      for (CustomDay day in month.days) {
        if (day.date.isAtTheSameDayAs(date) && !day.hidden) {
          day.data = data;
          notify();
          return true;
        }
      }
    }
    return false;
  }

  void notify() {
    datePicker.notify();
  }
}
