# customizable_date_picker

A Customizable_date_picker

<img src="https://github.com/achreffaidi/customizable_date_picker/blob/master/doc/images/blue.gif" width="300"/>

## Features

* Fully Customizable with Custom Builders.
* Can Attach dynamic Data to each day.
* Default Version, Ready to Use.

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  customizable_date_picker: "^0.0.1"
```

In your library add the following import:

```dart
import 'package:customizable_date_picker/customizable_date_picker.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Simple Use

You can place one or multiple `SliverStickyHeader`s inside a `CustomScrollView`.

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

<img src="https://github.com/achreffaidi/customizable_date_picker/blob/master/doc/images/default.gif" width="300"/>

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

<img src="https://github.com/achreffaidi/customizable_date_picker/blob/master/doc/images/blue.gif" width="300"/>

<img src="https://github.com/achreffaidi/customizable_date_picker/blob/master/doc/images/pink.gif" width="300"/>

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

<img src="https://github.com/achreffaidi/customizable_date_picker/blob/master/doc/images/dynamic.gif" width="300"/>

You can find the complete example in the [Example](https://github.com/achreffaidi/customizable_date_picker/tree/master/example) project.

## Changelog

Please see the [Changelog](https://github.com/achreffaidi/customizable_date_picker/blob/master/CHANGELOG.md) page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/letsar/flutter_sticky_header/issues).  
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/letsar/flutter_sticky_header/pulls).
