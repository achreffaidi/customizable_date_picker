import 'dart:async';
import 'dart:math';
import 'package:customizable_date_picker/customizable_date_picker.dart';
import 'package:customizable_date_picker/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusinessDemo extends StatefulWidget {
  @override
  _BusinessDemoState createState() => _BusinessDemoState();
}

class _BusinessDemoState extends State<BusinessDemo> {
  CustomDatePickerController _controller = new CustomDatePickerController(
    start: DateTime.now().add(Duration(days: -300)),
    end: DateTime.now().add(Duration(days: 300)),
    generateCustomDay: generateDay
  );

  static CustomDay  generateDay(DateTime dateTime){
    Random random = new Random();
    int randomNumber = random.nextInt(200)+70;
    int state = random.nextInt(3)*random.nextInt(2)*random.nextInt(2);

    return CustomDay(dateTime, {"cost":randomNumber,"state":state});
  }
  DateTime firstDate ;
  DateTime lastDate ;
  @override
  void initState() {
    _controller.onRangeSelected = (DateTime start,DateTime end){
      firstDate = start ;
      lastDate = end;
      setState(() {
        getTotalSum();
      });
    };
    Future.delayed(Duration(seconds: 10,)).then((value) => _controller.scrollTo(DateTime.now()));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 450,
              child: Card(
                child: CustomDatePicker(
                    _controller,
                  dayItemBuilder: dayItemBuilder,
                  monthTitleBuilder: monthTitleBuilder,
                  headerBackgroundColor: Colors.blue,
                  headerTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Card(
              child: Container(
                height: 100,
                child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Days : $numberOfDays"),
                    Text("Cost : $sum TND"),
                  Text("Discount : $discount%"),
                    Text("TOTAL : ${sum-sum*discount/100} TND",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                  ],
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
  int sum = 0 ;
  int numberOfDays = 0 ;
  int discount = 0 ;
  getTotalSum(){
    List<CustomDay> list = _controller.getListOfSelectedDays();
     sum = 0 ;
    for(CustomDay x in list){
      if(x.data["state"]!=0){
        int sum = 0 ;
        int numberOfDays = 0 ;
        int discount = 0 ;
        _controller.removeSelect();
        setState(() {

        });
        break;

      }
      if(x.data!=null)sum+= x.data["cost"];
    }
    numberOfDays = list.length;
    if(list.length<3){
      discount = 0 ;
    }else if (list.length<6){
      discount = 10 ;
    }else{
      discount = 15 ;
    }
  }
  Widget dayItemBuilder(CustomDay day, int index) {
    bool isSelected = false;
    var borderSide = BorderSide(
      color: Colors.blue,
      width: 2.0,
    );
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
        br = Border(
            right: borderSide,
            left: borderSide,
            top: borderSide,
            bottom: borderSide
        );
      } else if (day.date.isAtTheSameDayAs(firstDate)) {
        br = Border(
          left: borderSide,
          top: borderSide,
          bottom: borderSide
        );
      } else if (day.date.isAtTheSameDayAs(lastDate)) {
        br = Border(
            right: borderSide,
            top: borderSide,
            bottom: borderSide
        );


      } else {

        br =  br = Border(
            top: borderSide,
            bottom: borderSide
        );
      }
    }
    TextStyle style ;
    if(day.hidden){
      style = TextStyle(color: Colors.transparent);
    }else{
      if(isSelected){
        style = TextStyle( fontSize: 18,fontWeight: FontWeight.w900 , color: Colors.black);
      }else{
        style = TextStyle(fontWeight: FontWeight.w700 , color: Colors.black);
      }
    }

    Color topColor = Colors.transparent ;
    if(day.data!=null&& !day.hidden){
      if(day.data["state"]==1){
        topColor = Color.lerp(Colors.grey, Colors.transparent, 0.5);
      }
      if(day.data["state"]==2){
        topColor = Color.lerp(Colors.red, Colors.transparent, 0.5);
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

          height: 70,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Opacity(
                  opacity: day.hidden?0:1,
                  child: Container(
                      decoration: BoxDecoration(
                          border: br,
                          shape: BoxShape.rectangle,
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            day.date.day.toString(),
                            style: style,
                          ),
                          day.data!=null&&day.data["state"]==0 ?Text(day.data["cost"].toString()+" DT",style: TextStyle(fontSize: 10,color: Colors.green),):Container(),
                        ],
                      )),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: topColor,
                ),
              )
            ],
          ),
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
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Colors.purple),
            )),
      ],
    );
  }
}
