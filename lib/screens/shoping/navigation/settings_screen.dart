import 'package:flutter/material.dart';
import 'package:new_flutter_shop_app/conestance/const.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Text('logout'),
        onTap: () {
          print('logout');
          signOut(context);
        },
      ),
    );
  }
}
