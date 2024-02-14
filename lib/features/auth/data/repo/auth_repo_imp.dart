import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone_bloc/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone_bloc/core/firebase_constants/firebase_storage.dart';
import 'package:facebook_clone_bloc/core/widgets/toast.dart';
import 'package:facebook_clone_bloc/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      final credential = _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  ////////////////////////

  @override
  Future<UserCredential?> createAccount(
      {required String fullName,
      required DateTime birthday,
      required String gender,
      required String email,
      required String password,
      required File? image}) async {
    late String? download;
    try {
      // storing image in firebase storage
      final imagePath = _storage
          .ref(FirebaseStorageFolders.profilePics)
          .child(FirebaseAuth.instance.currentUser!.uid);

      // getting picture url

      if (image == null) {
        return null;
      }

      final credential = _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final imageSnapshot = await imagePath.putFile(image);
      download = await imageSnapshot.ref.getDownloadURL();

      // getting object from the user model
      UserModel user = UserModel(
          fullName: fullName,
          birthDay: birthday,
          gender: gender,
          email: email,
          password: password,
          profilePicUrl: download,
          uid: _firebaseAuth.currentUser!.uid,
          friends: [],
          sentRequests: [],
          receivedRequests: []);

      // stores the user data in firebase firestore docs
      await _firestore
          .collection(FirebaseCollectionCategoryName.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .set(user.toMap());

      return credential;
    } catch (e) {
      showToastMessage(text: "Failed to create account.\nplease put an image");
      return null;
    }
  }

  @override
  Future<UserModel> getUserInfo(String userId) async {
    final userData = await _firestore
        .collection(FirebaseCollectionCategoryName.users)
        .doc(userId)
        .get();

    // taking user object from remote source
    final user = UserModel.fromMap(userData.data()!);
    return user;
  }

  @override
  Future<String?> signOut() async {
    try {
      _firebaseAuth.signOut();
      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> verifyEmail() async {
    final user = _firebaseAuth.currentUser;
    try {
      if (user != null) {
        print("sent");
        user.sendEmailVerification();
      }
      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }
}
