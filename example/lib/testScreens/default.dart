import 'package:customizable_date_picker/customizable_date_picker.dart';
import 'package:flutter/material.dart';

class DefaultDemo extends StatefulWidget {
  @override
  _DefaultDemoState createState() => _DefaultDemoState();
}

class _DefaultDemoState extends State<DefaultDemo> {
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
}
