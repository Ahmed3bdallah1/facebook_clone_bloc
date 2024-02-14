import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';

abstract class AuthRepo {
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential?> createAccount({
    required String fullName,
    required DateTime birthday,
    required String gender,
    required String email,
    required String password,
    required File? image,
  });

  Future<String?> signOut();

  Future<UserModel> getUserInfo(String userId);

  Future<String?> verifyEmail();


}
