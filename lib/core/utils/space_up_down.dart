import 'package:flutter/material.dart';

Widget spaceDown(
  double height, {
  Color? color = Colors.transparent,
  double width = 0,
  EdgeInsetsGeometry? margin,
}) {
  return Container(
    margin: margin,
    color: color,
    width: width,
    child: SizedBox(height: height),
  );
}

Widget spaceSide(
  double width, {
  Color? color = Colors.transparent,
  double height = 0,
  EdgeInsetsGeometry? margin,
}) {
  return Container(
    margin: margin,
    color: color,
    height: height,
    child: SizedBox(height: width),
  );
}
