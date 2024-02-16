import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone_bloc/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone_bloc/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone_bloc/core/widgets/toast.dart';
import 'package:facebook_clone_bloc/features/auth/data/repo/auth_repo_imp.dart';
import 'package:facebook_clone_bloc/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepoImp authRepoImp;

  AuthCubit(this.authRepoImp) : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(SignInLoading());
      final userCredential =
          await authRepoImp.signIn(email: email, password: password);
      if (userCredential != null) {
        emit(SignInSuccess(userCredential.user!));
      } else {
        emit(SignInFailure('Failed to sign in'));
      }
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }

  Future<void> signUp(
      {required String fullName,
      required DateTime birthday,
      required String gender,
      required String email,
      required String password,
      required File? image}) async {
    try {
      emit(CreateAccountLoading());
      final userCredential = await authRepoImp.createAccount(
        fullName: fullName,
        birthday: birthday,
        gender: gender,
        email: email,
        password: password,
        image: image,
      );
      if (userCredential != null) {
        emit(CreateAccountSuccess(userCredential.user!));
      } else {
        emit(CreateAccountFailure('Failed to create account'));
      }
    } catch (e) {
      emit(CreateAccountFailure(e.toString()));
    }
  }

  Future<void> verifyEmail() async {
    try {
      emit(VerifyAccountLoading());
      final verifyEmailMessage = await authRepoImp.verifyEmail();
      if (verifyEmailMessage == null) {
        showToastMessage(text: 'Email verification sent to your email');
        emit(VerifyAccountSuccess());
      } else {
        emit(VerifyAccountFailure(verifyEmailMessage));
      }
    } catch (e) {
      emit(VerifyAccountFailure(e.toString()));
    }
  }

  Future<void> getUserInfo(String userId) async {
    try {
      emit(GetUserInfoLoading());
      final userInfo = await authRepoImp.getUserInfo(userId);
      emit(GetUserInfo(userInfo));
    } catch (e) {
      emit(GetUserInfoError(e.toString()));
    }
  }

  Stream<UserModel> getUserInfoAsStream(String userId) {
    final controller = StreamController<UserModel>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.users)
        .where(FirebaseFieldNames.uid, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first;
        final user = UserModel.fromMap(userData.data());
        controller.sink.add(user);
      }
    });

    sub.onError((error) {
      controller.addError(error);
    });

    sub.onDone(() {
      controller.close();
    });

    return controller.stream;
  }

  Future<void> signOut() async {
    try {
      emit(SignOutLoading());
      final signOutMessage = await authRepoImp.signOut();
      if (signOutMessage == null) {
        emit(SignOutSuccess());
      } else {
        emit(SignOutFailure(signOutMessage));
      }
    } catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }
}
