import 'package:customizable_date_picker/customizable_date_picker.dart';
import 'package:customizable_date_picker/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PinkDemo extends StatefulWidget {
  @override
  _PinkDemoState createState() => _PinkDemoState();
}

class _PinkDemoState extends State<PinkDemo> {
  CustomDatePickerController _controller = new CustomDatePickerController();
  DateTime firstDate;
  DateTime lastDate;
  @override
  void initState() {
    _controller.onRangeSelected = (DateTime start, DateTime end) {
      firstDate = start;
      lastDate = end;
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Card(
          child: CustomDatePicker(
            _controller,
            dayItemBuilder: dayItemBuilder,
            monthTitleBuilder: monthTitleBuilder,
            headerBackgroundColor: Colors.pinkAccent,
            headerTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            background: Opacity(
                opacity: 0.3,
                child: Image.network(
                  'https://i.pinimg.com/originals/3a/48/58/3a48581702cff7eed8bebd467133466e.png',
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }

  Widget dayItemBuilder(CustomDay day, int index) {
    Color color = Colors.transparent;
    Color nextColor = Colors.transparent;
    BoxDecoration decoration;
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
    if (isSelected) {
      color = Color.lerp(Colors.pinkAccent, Colors.white, index / 60);
      nextColor = Color.lerp(Colors.pinkAccent, Colors.white, (index + 1) / 60);
      decoration = BoxDecoration(
          gradient: LinearGradient(
        colors: [color, nextColor, Colors.white],
        stops: [0, 0.5, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ));
    }

    TextStyle style;
    if (day.hidden) {
      style = TextStyle(color: Colors.transparent);
    } else {
      if (isSelected) {
        style = TextStyle(
            fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white);
      } else {
        style = TextStyle(fontWeight: FontWeight.w700, color: Colors.black);
      }
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _controller.onDaySelect(day.date);
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: decoration,
          height: 50,
          child: Center(
              child: Container(
                  child: Text(
            day.date.day.toString(),
            style: style,
          ))),
        ),
      ),
    );
  }

  Widget monthTitleBuilder(DateTime date) {
    final f = new DateFormat('MMMM, yyyy');
    String formattedText = f.format(date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 15, top: 30),
            child: Text(
              formattedText,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink),
            )),
      ],
    );
  }
}
