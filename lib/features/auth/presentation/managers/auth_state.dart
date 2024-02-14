import 'package:facebook_clone_bloc/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInSuccess extends AuthState {
  final User user;

  SignInSuccess(this.user);
}

class SignInLoading extends AuthState {}
class SignOutSuccess extends AuthState {}
class SignOutLoading extends AuthState {}
class SignOutFailure extends AuthState {
  final String error;

  SignOutFailure(this.error);
}

class SignInFailure extends AuthState {
  final String error;

  SignInFailure(this.error);
}

class CreateAccountSuccess extends AuthState {
  final User user;

  CreateAccountSuccess(this.user);
}

class CreateAccountLoading extends AuthState {}

class CreateAccountFailure extends AuthState {
  final String error;

  CreateAccountFailure(this.error);
}

class VerifyAccountLoading extends AuthState {}

class VerifyAccountSuccess extends AuthState {}

class VerifyAccountFailure extends AuthState {
  final String error;

  VerifyAccountFailure(this.error);
}

class GetUserInfo extends AuthState {
  final UserModel userModel;

  GetUserInfo(this.userModel);
}

class GetUserInfoLoading extends AuthState {}

class GetUserInfoError extends AuthState {
  final String error;

  GetUserInfoError(this.error);
}
