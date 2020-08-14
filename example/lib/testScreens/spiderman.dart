import 'package:customizable_date_picker/customizable_date_picker.dart';
import 'package:customizable_date_picker/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpiderManDemo extends StatefulWidget {
  @override
  _SpiderManDemoState createState() => _SpiderManDemoState();
}

class _SpiderManDemoState extends State<SpiderManDemo> {
  CustomDatePickerController _controller = new CustomDatePickerController();
  DateTime firstDate ;
  DateTime lastDate ;
  @override
  void initState() {
    _controller.onRangeSelected = (DateTime start,DateTime end){
      firstDate = start ;
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
            headerBackgroundColor: Colors.red,
            headerTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget dayItemBuilder(CustomDay day, int index) {
    Color color = Colors.transparent;
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
        color = Colors.blue;
      } else if (day.date.isAtTheSameDayAs(firstDate)) {
        br = BorderRadius.only(
            topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0));
 color = Colors.red;
      } else if (day.date.isAtTheSameDayAs(lastDate)) {
        br = BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0));
        color = Colors.red;

      } else {
        color = Color.lerp(Colors.blue, Colors.white, index/60);
        br = BorderRadius.only();
      }
    }
    TextStyle style ;
    if(day.hidden){
      style = TextStyle(color: Colors.transparent);
    }else{
      if(isSelected){
        style = TextStyle( fontSize: 18,fontWeight: FontWeight.w900 , color: Colors.white);
      }else{
        style = TextStyle(fontWeight: FontWeight.w700 , color: Colors.black);
      }
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _controller.onDaySelect(day.date);
          setState(() {

          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: br),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width*.7,
          height: 3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue,Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  formattedText,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Colors.red),
                )),
          ],
        ),
      ],
    );
  }
}
