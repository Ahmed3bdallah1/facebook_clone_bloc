import 'package:facebook_clone_bloc/core/constants/custom_buttom_transition.dart';
import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_state.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/screens/comments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/constants/color_constants.dart';
import 'icon_button.dart';

class LikeCommentShare extends StatelessWidget {
  const LikeCommentShare({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        PostsCubit cubit = PostsCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconTextButton(
              icon: isLiked
                  ? FontAwesomeIcons.solidThumbsUp
                  : FontAwesomeIcons.thumbsUp,
              color: isLiked ? ColorsConstants.blueColor : null,
              label: 'Like',
              onPressed: () {
                cubit.likeAndDislikePosts(
                    postId: post.postId, likes: post.likes);
              },
            ),
            IconTextButton(
              icon: FontAwesomeIcons.solidMessage,
              label: 'Comment',
              onPressed: () {
                Navigator.push(
                    context,
                    customPageRouteTransition(CommentsScreen(
                      post: post,
                    )));
              },
            ),
            const IconTextButton(
              icon: FontAwesomeIcons.share,
              label: 'Share',
            ),
          ],
        );
      },
    );
  }
}
