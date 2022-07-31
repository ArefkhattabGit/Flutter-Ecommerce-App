abstract class SocialLoginState {}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSuccess extends SocialLoginState {}

class SocialLoginError extends SocialLoginState {
  final String error;

  SocialLoginError(this.error);
}

class SocialLoginChangePasswordVisibility extends SocialLoginState {}
