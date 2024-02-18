import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone_bloc/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone_bloc/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone_bloc/core/widgets/toast.dart';
import 'package:facebook_clone_bloc/features/posts/data/repos/posts_repo.dart';
import 'package:facebook_clone_bloc/features/posts/models/comment_model.dart';
import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PostsRepoImp extends PostsRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String?> post(
      {required String post, File? file, required String postType}) async {
    try {
      final String postId = const Uuid().v1();
      final String userId = _auth.currentUser!.uid;
      final DateTime shareTime = DateTime.now();

      final path = _storage.ref(postType).child(postId);
      final taskSnapshot = await path.putFile(file!);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      PostModel postModel = PostModel(
          postId: postId,
          userId: userId,
          post: post,
          postType: postType,
          fileUrl: downloadUrl,
          createdAt: shareTime,
          likes: []);

      _firestore
          .collection(FirebaseCollectionCategoryName.posts)
          .doc(postId)
          .set(postModel.toMap());

      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> comment(
      {required String text, required String postId}) async {
    try {
      final String commentId = const Uuid().v1();
      final String userId = _auth.currentUser!.uid;
      final DateTime commentingTime = DateTime.now();

      CommentModel comment = CommentModel(
        commentId: commentId,
        authorId: userId,
        postId: postId,
        text: text,
        createdAt: commentingTime,
        likes: const [],
      );

      _firestore
          .collection(FirebaseCollectionCategoryName.comments)
          .doc(commentId)
          .set(comment.toMap());

      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> likeAndDislikePosts(
      {required String postId, required List<String> likes}) async {
    try {
      final String userId = _auth.currentUser!.uid;

      if (likes.contains(userId)) {
        _firestore
            .collection(FirebaseCollectionCategoryName.posts)
            .doc(postId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayRemove([userId])
        });
      } else {
        _firestore
            .collection(FirebaseCollectionCategoryName.posts)
            .doc(postId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayUnion([userId])
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> likeDislikeComment(
      {required String commentId, required List<String> likes}) async {
    try {
      final String userId = _auth.currentUser!.uid;

      if (likes.contains(userId)) {
        _firestore
            .collection(FirebaseCollectionCategoryName.comments)
            .doc(commentId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayRemove([userId])
        });
      } else {
        _firestore
            .collection(FirebaseCollectionCategoryName.comments)
            .doc(commentId)
            .update({
          FirebaseFieldNames.likes: FieldValue.arrayUnion([userId])
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Stream<Iterable<PostModel>> getAllPosts() {
    final controller = StreamController<Iterable<PostModel>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.posts)
        .orderBy(FirebaseFieldNames.datePublished, descending: true)
        .snapshots()
        .listen((snapshot) {
      final posts = snapshot.docs.map(
        (postData) => PostModel.fromMap(
          postData.data(),
        ),
      );
      controller.sink.add(posts);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Stream<Iterable<PostModel>> getAllVideos() {
    final controller = StreamController<Iterable<PostModel>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.posts)
        .where(FirebaseFieldNames.postType, isEqualTo: "video")
        .orderBy(FirebaseFieldNames.datePublished, descending: true)
        .snapshots()
        .listen((snapshot) {
      final posts = snapshot.docs.map(
        (postData) => PostModel.fromMap(
          postData.data(),
        ),
      );
      controller.sink.add(posts);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Stream<Iterable<PostModel>> usersIdPostsProvider(String userId) {
    final controller = StreamController<Iterable<PostModel>>();
    FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.posts)
        .where(FirebaseFieldNames.posterId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        final posts = snapshot.docs.map(
          (postData) => PostModel.fromMap(postData.data()),
        );
        print(posts.length);
        controller.sink.add(posts);
      },
    );

    controller.onCancel = () {
      controller.close();
    };

    return controller.stream;
  }

  Stream<Iterable<CommentModel>> getAllComments({required String postId}) {
    final controller = StreamController<Iterable<CommentModel>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.comments)
        .where(FirebaseFieldNames.postId, isEqualTo: postId)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .snapshots()
        .listen((event) {
      final comments = event.docs.map(
        (commentData) => CommentModel.fromMap(
          commentData.data(),
        ),
      );
      controller.sink.add(comments);
    });

    controller.onCancel = () {
      controller.close();
      sub.cancel();
    };

    return controller.stream;
  }
}
