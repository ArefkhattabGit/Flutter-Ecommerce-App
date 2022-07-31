import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/screens/login/shop_login_screen.dart';
import 'package:new_flutter_shop_app/screens/shop_boarding_screen.dart';
import 'package:new_flutter_shop_app/screens/shoping/cubit/shop_cubit.dart';
import 'package:new_flutter_shop_app/screens/shoping/shop_screen.dart';
import 'package:new_flutter_shop_app/shardPreferance/shard_preferance.dart';

import 'block/block_observer.dart';
import 'dioHelper/api_dio_helper.dart';
import 'models/MyClass.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() {
    // Use blocs...
    DioHelper.init();
  }, blocObserver: MyBlocObserver());

  await MyShardPreferance.init();

  Widget widget;

  Future onBoarding = MyShardPreferance.getData(key: 'onBoarding');

  Future<String?> token = MyShardPreferance.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopScreen();
    } else {
      widget = LoginUserScreen();
    }
  } else {
    widget = BoardingScreen();
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(
    onBoarding: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget onBoarding;

  MyApp({required this.onBoarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getProfileData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 75.0,
            backgroundColor: Colors.white38,
            type: BottomNavigationBarType.fixed,
          ),
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
            elevation: 0.0,
            color: Colors.white,
          ),
        ),
        home: LoginUserScreen(),
      ),
    );
  }
}
