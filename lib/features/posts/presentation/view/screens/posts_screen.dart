import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/post_widgets/make_post_widget.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/post_widgets/posts_list.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        MakePostWidget(),
        // StoryListView(),
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        PostsList(),
      ],
    );
  }
}
