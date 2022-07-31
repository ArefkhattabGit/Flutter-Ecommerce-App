import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_flutter_shop_app/models/login_model.dart';
import 'package:new_flutter_shop_app/screens/login/cubit/cubit.dart';
import 'package:new_flutter_shop_app/screens/login/cubit/states.dart';
import 'package:new_flutter_shop_app/screens/social/bloc/social_login_state.dart';
import 'package:new_flutter_shop_app/widgets/button_widgets.dart';
import 'package:new_flutter_shop_app/widgets/form_field_widgets.dart';

import 'bloc/social_login_cubit.dart';

class LoginUserScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is SocialLoginError) {}
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'login Now to show best offers in the app',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defualtFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null) {
                              return 'please enter your email address';
                            }
                          },
                          lableText: 'Email Address',
                          prefexIcon: Icons.email),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defualtFormField(
                          sufeixPress: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          ispassword: true,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              //  print('login button clicked');

                              SocialLoginCubit.get(context).userFirebaseLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'please enter your  password';
                            }
                          },
                          lableText: 'password',
                          prefexIcon: Icons.lock),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        builder: (context) => defualtButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('login button clicked');
                                SocialLoginCubit.get(context).userFirebaseLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            textBtn: 'login',
                            isUpperCase: true),
                        fallback: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
                        condition: state is! ShopLoginLoadingState,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'REGISTER NOW',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void displaySuccessToast(ShopLoginModel messagemodle) {
    Fluttertoast.showToast(
        msg: messagemodle.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void displayErrorToast(ShopLoginModel messagemodle) {
    Fluttertoast.showToast(
        msg: messagemodle.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
