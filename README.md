# customizable_date_picker

A Customizable_date_picker

<div style="text-align:center"><img src="https://raw.githubusercontent.com/achreffaidi/customizable_date_picker/master/doc/images/blue.gif" width="300"/></div>

## Features

* Fully Customizable with Custom Builders.
* Can Attach dynamic Data to each day.
* Default Version, Ready to Use.

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  customizable_date_picker: "^0.0.3"
```

In your library add the following import:

```dart
import 'package:customizable_date_picker/customizable_date_picker.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Attributes
 
### CustomDatePicker
|attribute|type|description|
|--|--|--|
|controller |CustomDatePickerController | Widget controller |
|activeDayTextStyle |TextStyle | normal day color |
|hiddenDayTextStyle |TextStyle | hidden day color |
|headerTextStyle | TextStyle| TextStyle of days abbreviations| 
|selectedDaysColor |Color | color of selected day |
|headerBackgroundColor | Color| Color of the Header|
|daysOfWeek |List<String> | Days abbreviations |
|background |Widget | Background widget,could be anything, Image,Animations,Colors...|
|dayItemBuilder | Widget Function(CustomDay day, int index)|day item builder|
|monthTitleBuilder |Widget Function(DateTime date) |month Title Item Builder|

Warning:
> One you chose to use a builder, most other styling attributes will be ignored.

### CustomDatePickerController
|attribute|type|description|
|--|--|--|
|start |DateTime | first month in the calendar |
|end |DateTime | last month in the calendar |
|generateCustomDay |CustomDay Function(DateTime firstDate, DateTime lastDate) | generate dynamic for each Day |


## Simple Use

```dart
CustomDatePickerController _controller = new CustomDatePickerController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Card(
          child: CustomDatePicker(
            _controller
          ),
        ),
      ),
    );
  }
```


<div style="text-align:center"><img src="https://raw.githubusercontent.com/achreffaidi/customizable_date_picker/master/doc/images/default.gif" width="300"/></div>


You can find the complete example in the [Example](https://github.com/achreffaidi/customizable_date_picker/tree/master/example) project.



## Using Custom Builder

You can specify how every part of the Widget should be built: 

```dart
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
```

<div style="text-align:center"><img src="https://raw.githubusercontent.com/achreffaidi/customizable_date_picker/master/doc/images/blue.gif" width="300"/></div>


<div style="text-align:center"><img src="https://raw.githubusercontent.com/achreffaidi/customizable_date_picker/master/doc/images/pink.gif" width="300"/></div>


You can find the complete example in the [Example](https://github.com/achreffaidi/customizable_date_picker/tree/master/example) project.

## PopUp using AlertDialog 

```dart
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
```

<div style="text-align:center"><img src="https://raw.githubusercontent.com/achreffaidi/customizable_date_picker/master/doc/images/popup.gif" width="300"/></div>


You can find the complete example in the [Example](https://github.com/achreffaidi/customizable_date_picker/tree/master/example) project.

## Using dynamic Data

You can use generateCustomDay to initialize CustomDay Objects with dynamic data. 

```dart
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
```
You can also set Data using 
```dart
controler.setDayData(DateTime date, dynamic data)
```

<div style="text-align:center"><img src="https://raw.githubusercontent.com/achreffaidi/customizable_date_picker/master/doc/images/dynamic.gif" width="300"/></div>

You can find the complete example in the [Example](https://github.com/achreffaidi/customizable_date_picker/tree/master/example) project.

## Changelog

Please see the [Changelog](https://github.com/achreffaidi/customizable_date_picker/blob/master/CHANGELOG.md) page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/achreffaidi/customizable_date_picker/issues).  
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/achreffaidi/customizable_date_picker/pulls).
