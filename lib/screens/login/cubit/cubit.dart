import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/apiEndPoint/api_end_point.dart';
import 'package:new_flutter_shop_app/models/login_model.dart';
import 'package:new_flutter_shop_app/screens/login/cubit/states.dart';
import 'package:new_flutter_shop_app/dioHelper/api_dio_helper.dart';
import 'package:new_flutter_shop_app/shardPreferance/shard_preferance.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((response) {
      print('Login Status code  :   ${response.statusCode}');
      print(response.data);


      loginModel = ShopLoginModel.fromJson(response.data);
      print(loginModel!.status);
      print(loginModel!.message);
      //   print(loginModel!.data!.token);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopLoginVisibilityPassword());
  }
}
