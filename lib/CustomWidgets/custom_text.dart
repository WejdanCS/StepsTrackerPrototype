import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  CustomText({this.text, this.fontWeight, this.fontSize});


  @override
  Widget build(BuildContext context) {
    return Text(this.text,style: TextStyle(color: Colors.white,fontSize: this.fontSize,fontWeight: this.fontWeight),);

  }
}
