import 'package:facebook_clone_bloc/features/posts/models/comment_model.dart';
import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class UploadPostsLoading extends PostsState {}

class UploadPostsSuccess extends PostsState {}

class UploadPostsError extends PostsState {
  final String error;

  UploadPostsError(this.error);
}

class GetPostsLoading extends PostsState {}

class GetPostsSuccess extends PostsState {
  final Iterable<PostModel> posts;

  GetPostsSuccess(this.posts);
}

class GetPostsError extends PostsState {
  final String error;

  GetPostsError(this.error);
}

class GetCommentsLoading extends PostsState {}

class GetCommentsSuccess extends PostsState {
  final Iterable<CommentModel> comments;

  GetCommentsSuccess(this.comments);
}

class GetCommentsError extends PostsState {
  final String error;

  GetCommentsError(this.error);
}

class UploadCommentLoading extends PostsState {}

class UploadCommentSuccess extends PostsState {}

class UploadCommentError extends PostsState {
  final String error;

  UploadCommentError(this.error);
}

class LikeAndDislikeLoading extends PostsState {}

class LikeAndDislikeSuccess extends PostsState {}

class LikeAndDislikeError extends PostsState {
  final String error;

  LikeAndDislikeError(this.error);
}
