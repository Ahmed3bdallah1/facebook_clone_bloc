import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/comment_widgets/comments_list.dart';
import 'package:flutter/material.dart';

import '../widgets/comment_widgets/text_field.dart';

class CommentsScreen extends StatelessWidget {
  final PostModel post;

  const CommentsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Column(
        children: [
          CommentsList(postModel: post),
          CommentTextField(postId: post.postId)
        ],
      ),
    );
  }
}
