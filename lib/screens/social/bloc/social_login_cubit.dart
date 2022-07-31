import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/screens/social/bloc/social_login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitial());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userFirebaseLogin(
      {required String email, required String password}) async {
    emit(SocialLoginLoading());

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccess());
      print(value.additionalUserInfo!.username);
    }).catchError((error) {
      emit(SocialLoginError(error));

      print(error.toString());
    });

    // Firebase Lines .

    //emit the success Login
  }
}
