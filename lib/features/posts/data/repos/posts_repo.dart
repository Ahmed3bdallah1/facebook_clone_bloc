import 'dart:io';

import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';

abstract class PostsRepo {
  Future<String?> post({
    required String post,
    required File file,
    required String postType,
  });

  Future<String?> likeAndDislikePosts({
    required String postId,
    required List<String> likes,
  });

  Future<String?> comment({
    required String text,
    required String postId,
  });

  Future<String?> likeDislikeComment({
    required String commentId,
    required List<String> likes,
  });

  Stream<Iterable<PostModel>> getAllPosts();

  Stream<Iterable<PostModel>> getAllVideos();

  Stream<Iterable<PostModel>> usersIdPostsProvider(String userId);
}
