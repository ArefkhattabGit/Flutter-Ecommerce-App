import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/screens/search/search_screen.dart';
import 'package:new_flutter_shop_app/screens/shoping/cubit/shop_cubit.dart';
import 'package:new_flutter_shop_app/screens/shoping/state/shop_state.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);

          return Scaffold(
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
            //  backgroundColor: Color(0x44000000),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
              ],
              title: const Text(
                'Shoping',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.navigationItems,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
          );
        });
  }
}
