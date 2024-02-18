import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_state.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/post_widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        PostsCubit cubit = PostsCubit.get(context);
        final posts = cubit.postsRepo.getAllPosts();

        return StreamBuilder(
            stream: posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }else if(snapshot.hasData){
                  final postsList = snapshot.data;

                  if (postsList!.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Container(),
                    );
                  }

                  return SliverList.separated(
                    itemCount: postsList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final post = postsList.elementAt(index);
                      return PostTile(post: post);
                    },
                  );
              }

              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("Error"),
                ),
              );
            });

        // if (state is GetPostsSuccess) {

        // } else if (state is GetPostsError) {
        // } else {
        //
        // }
      },
    );
  }
}
