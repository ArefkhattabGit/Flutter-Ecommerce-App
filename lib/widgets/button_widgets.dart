import 'package:flutter/material.dart';

Widget defualtButton({
  required VoidCallback onPressed,
  required String textBtn,
  Color background = Colors.blue,
  double radius = 10,
  bool isUpperCase = true,
}) =>
    Container(
      height: 45.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        color: background,
        onPressed: onPressed,
        child: Text(
          isUpperCase ? textBtn.toUpperCase() : textBtn,
          style: TextStyle(
              color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
