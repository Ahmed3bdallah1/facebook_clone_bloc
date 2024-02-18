import 'package:facebook_clone_bloc/core/firebase_constants/firebase_field_names.dart';

class PostModel {
  final String postId;
  final String userId;
  final String post;
  final String postType;
  final String fileUrl;
  final DateTime createdAt;
  final List<String> likes;

  const PostModel({
    required this.postId,
    required this.userId,
    required this.post,
    required this.postType,
    required this.fileUrl,
    required this.createdAt,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: userId,
      FirebaseFieldNames.content: post,
      FirebaseFieldNames.fileUrl: fileUrl,
      FirebaseFieldNames.datePublished: createdAt.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes,
      FirebaseFieldNames.postType: postType,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map[FirebaseFieldNames.postId] ?? '',
      userId: map[FirebaseFieldNames.posterId] ?? '',
      post: map[FirebaseFieldNames.content] ?? '',
      postType: map[FirebaseFieldNames.postType] ?? '',
      fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.datePublished] ?? 0,
      ),
      likes: List<String>.from(
        (map[FirebaseFieldNames.likes] ?? []),
      ),
    );
  }
}
