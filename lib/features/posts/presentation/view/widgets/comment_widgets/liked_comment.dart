import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/features/posts/models/comment_model.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentLikes extends StatelessWidget {
  const CommentLikes({Key? key, required this.comment}) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    final isLiked =
        comment.likes.contains(FirebaseAuth.instance.currentUser!.uid);

    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                comment.createdAt.toString().substring(11, 16),
                style: const TextStyle(fontSize: 14),
              ),
              TextButton(
                onPressed: () async {
                  await PostsCubit.get(context).likeDislikeComment(
                    commentId: comment.commentId,
                    likes: comment.likes,
                  );
                },
                child: Text(
                  'like',
                  style: TextStyle(
                    color: isLiked
                        ? ColorsConstants.blueColor
                        : ColorsConstants.darkGreyColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 10,
                backgroundColor: ColorsConstants.blueColor,
                child: FaIcon(
                  FontAwesomeIcons.solidThumbsUp,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                comment.likes.length.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
