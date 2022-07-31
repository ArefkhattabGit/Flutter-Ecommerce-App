import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/apiEndPoint/api_end_point.dart';
import 'package:new_flutter_shop_app/conestance/const.dart';
import 'package:new_flutter_shop_app/dioHelper/api_dio_helper.dart';
import 'package:new_flutter_shop_app/models/categories_model.dart';
import 'package:new_flutter_shop_app/models/change_favorite_model.dart';
import 'package:new_flutter_shop_app/models/home_model.dart';
import 'package:new_flutter_shop_app/models/login_model.dart';
import 'package:new_flutter_shop_app/screens/shoping/navigation/categories_screen.dart';
import 'package:new_flutter_shop_app/screens/shoping/navigation/favorites_screen.dart';
import 'package:new_flutter_shop_app/screens/shoping/navigation/products_screen.dart';
import 'package:new_flutter_shop_app/screens/shoping/navigation/settings_screen.dart';
import 'package:new_flutter_shop_app/screens/shoping/state/shop_state.dart';
import 'package:new_flutter_shop_app/shardPreferance/shard_preferance.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'category',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'settings',
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaviationBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadinDataState());

    DioHelper.getData(url: HOME, token: token, lang: 'en').then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.banners[0].image);
      print(homeModel!.status);

      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });

      print(favorite.toString());

      emit(ShopLoadingDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoadingDataErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoryData() {
    emit(ShopLoadingCategoriesSuccessState());

    DioHelper.getData(url: GET_CATEGORIES, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data!.currentPage);
      print(categoriesModel!.status);
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoadingCategoriesErrorState(error.toString()));
    });
  }

  ShopLoginModel? model;

  void getProfileData() {
    emit(ShopProfileLoadingState());
    DioHelper.getData(url: PROFILE, token: token, lang: 'en').then((value) {
      model = ShopLoginModel.fromJson(value.data);
      String pr = '________________________';
      print(model!.data!.name! + pr);

      emit(ShopProfileSuccessState());
    }).catchError((error) {
      emit(ShopProfileErrorState(error.toString()));
      print(error.toString());
    });
  }

  favoritModel? favModel;

  void ChangeFavorites(int productID) {
    DioHelper.postData(
            url: FAVORITES, data: {"product_id": productID}, token: token)
        .then((value) {
      favModel = favoritModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }
}
