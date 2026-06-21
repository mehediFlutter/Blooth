import 'package:flutter/material.dart';

Widget infoChip(String label, String value) {
  return Text(
    '$label: $value',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  );
}
