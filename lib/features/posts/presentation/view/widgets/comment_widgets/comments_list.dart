import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_tile.dart';

class CommentsList extends StatelessWidget {
  final PostModel postModel;

  const CommentsList({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    PostsCubit cubit = PostsCubit.get(context);
    final comments = cubit.postsRepo.getAllComments(postId: postModel.postId);
    return Expanded(
      child: StreamBuilder(
        stream: comments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final commentsList = snapshot.data;
            if (commentsList!.isEmpty) {
              return Container();
            }

            return ListView.builder(
              itemCount: commentsList.length,
              itemBuilder: (context, index) {
                final comment = commentsList.elementAt(index);
                return CommentTile(
                  commentModel: comment,
                );
              },
            );
          } else {
            return const Center(child: Icon(Icons.error));
          }
        },
      ),
    );
  }
}
