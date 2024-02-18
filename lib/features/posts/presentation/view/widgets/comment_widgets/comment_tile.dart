import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/models/comment_model.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_state.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/profile_small_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'liked_comment.dart';

class CommentTile extends StatelessWidget {
  final CommentModel commentModel;

  const CommentTile({super.key, required this.commentModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CommentInfo(commentModel),
          CommentLikes(comment: commentModel),
        ],
      ),
    );
  }
}

class CommentInfo extends StatelessWidget {
  final CommentModel commentModel;

  const CommentInfo(this.commentModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      final user =
          AuthCubit.get(context).getUserInfoAsStream(commentModel.authorId);

      return StreamBuilder(
          stream: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileImage(userId: commentModel.authorId),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color:
                                ColorsConstants.messengerBlue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.fullName),
                            const SizedBox(height: 5),
                            Text(
                              commentModel.text,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasData) {
              return const Center(child: Icon(Icons.error));
            }
            return const Center(child: CircularProgressIndicator());
          });
    });
    // return user.when(data: (userData) {
    //
    // }, error: (error, stackTrace) {
    //
    // }, loading: () {
    //
    // });
  }
}
