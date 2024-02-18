import 'dart:async';
import 'dart:io';
import 'package:facebook_clone_bloc/core/widgets/toast.dart';
import 'package:facebook_clone_bloc/features/posts/data/repos/posts_repo_imp.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsRepoImp postsRepo;

  PostsCubit(this.postsRepo) : super(PostsInitial());

  static PostsCubit get(BuildContext context) => BlocProvider.of(context);

  Future<String?> post({
    required String post,
    File? file,
    required String postType,
  }) async {
    try {
      emit(UploadCommentLoading());
      final String? error = await postsRepo.post(
        post: post,
        file: file!,
        postType: postType,
      );

      if (error == null) {
        emit(UploadPostsSuccess());
        showToastMessage(text: "Post Uploaded Successfully");
        return null;
      } else {
        emit(UploadPostsError(error));
        showToastMessage(text: error);
        return error;
      }
    } catch (e) {
      emit(UploadPostsError(e.toString()));
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  Future<void> comment({
    required String text,
    required String postId,
  }) async {
    try {
      emit(UploadCommentLoading());
      final String? error = await postsRepo.comment(
        text: text,
        postId: postId,
      );

      if (error == null) {
        emit(UploadCommentSuccess());
      } else {
        emit(UploadCommentError(error));
      }
    } catch (e) {
      emit(UploadCommentError(e.toString()));
    }
  }

  Future<void> likeAndDislikePosts({
    required String postId,
    required List<String> likes,
  }) async {
    emit(LikeAndDislikeLoading());

    try {
      final String? error = await postsRepo.likeAndDislikePosts(
        postId: postId,
        likes: likes,
      );

      if (error == null) {
        emit(LikeAndDislikeSuccess());
      } else {
        emit(LikeAndDislikeError(error));
      }
    } catch (e) {
      emit(LikeAndDislikeError(e.toString()));
    }
  }

  Future<void> likeDislikeComment({
    required String commentId,
    required List<String> likes,
  }) async {
    emit(LikeAndDislikeLoading());

    try {
      final String? error = await postsRepo.likeDislikeComment(
        commentId: commentId,
        likes: likes,
      );

      if (error == null) {
        emit(LikeAndDislikeSuccess());
      } else {
        emit(LikeAndDislikeError(error));
      }
    } catch (e) {
      emit(LikeAndDislikeError(e.toString()));
    }
  }

  void fetchAllPostsById(String userId) {
    emit(GetPostsLoading());
    postsRepo.usersIdPostsProvider(userId).listen(
      (posts) {
        emit(GetPostsSuccess(posts));
      },
      onError: (error) {
        emit(GetPostsError(error.toString()));
      },
    );
  }
}
