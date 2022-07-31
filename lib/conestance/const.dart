import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:new_flutter_shop_app/screens/login/shop_login_screen.dart';
import 'package:new_flutter_shop_app/shardPreferance/shard_preferance.dart';

const String baseApiUrl = 'https://student.valuxapps.com/api/';
const String onBoarding = 'onBoarding';
const String token = '';

void signOut(BuildContext context) {
  MyShardPreferance.removeData(key: 'token').then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginUserScreen(),
          ),
          (route) => false);
    }
  });
}

TextStyle buildCustomTextStyle(
        {Color color = Colors.black,
        required double fontSize,
        FontWeight? fontWeight,
        TextOverflow? overflow}) =>
    TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
    );
