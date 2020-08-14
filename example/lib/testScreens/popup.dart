import 'package:customizable_date_picker/customizable_date_picker.dart';
import 'package:customizable_date_picker/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PopUpDemo extends StatefulWidget {
  @override
  _PopUpDemoState createState() => _PopUpDemoState();
}

class _PopUpDemoState extends State<PopUpDemo> {
  CustomDatePickerController _controller = new CustomDatePickerController();
  DateTime firstDate ;
  DateTime lastDate ;
  @override
  void initState() {
    _controller.onRangeSelected = (DateTime start,DateTime end){
      firstDate = start ;
      lastDate = end;
      _controller.notify();
    };
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(child: Text("Pick Date rage"),onPressed: _showPopUp,),
          SizedBox(height: 200,),
          firstDate==null?Container():Text("From : " +firstDate.toIso8601String().split("T")[0],style: TextStyle(fontSize: 20),),
          lastDate==null?Container():Text("To : " +lastDate.toIso8601String().split("T")[0],style: TextStyle(fontSize: 20),),
        ],
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
        color = Colors.black;
      } else if (day.date.isAtTheSameDayAs(firstDate)) {
        br = BorderRadius.only(
            topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0));
 color = Colors.black;
      } else if (day.date.isAtTheSameDayAs(lastDate)) {
        br = BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0));
        color = Colors.black;

      } else {
        color = Color.lerp(Colors.black, Colors.white, index/60);
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
                colors: [Colors.black,Colors.transparent],
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Colors.black),
                )),
          ],
        ),
      ],
    );
  }

  void _showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Date Picker"),
          content: Card(
            child: CustomDatePicker(
              _controller,
              dayItemBuilder: dayItemBuilder,
              monthTitleBuilder: monthTitleBuilder,
              headerBackgroundColor: Colors.black,
              headerTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
}
