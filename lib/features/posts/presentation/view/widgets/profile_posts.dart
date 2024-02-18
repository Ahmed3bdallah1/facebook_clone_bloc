import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/post_widgets/post_tile.dart';
import 'package:flutter/material.dart';

class ProfilePosts extends StatelessWidget {
  final String userId;

  const ProfilePosts({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final posts =
        PostsCubit.get(context).postsRepo.usersIdPostsProvider(userId);

    return StreamBuilder(
      stream: posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          var postsList = snapshot.data;

          return SliverList.separated(
            itemCount: postsList!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final post = postsList.elementAt(index);
              return PostTile(post: post);
            },
          );
        } else {
          return const SliverToBoxAdapter(child: Center(child: Text("error")));
        }
      },
    );
  }
}
