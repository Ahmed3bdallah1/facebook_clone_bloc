import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../managers/posts_state.dart';
import '../widgets/post_widgets/post_tile.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final videos = PostsCubit.get(context).postsRepo.getAllVideos();
        return StreamBuilder(
            stream: videos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final videosList = snapshot.data;
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final video = videosList.elementAt(index);
                          return Column(
                            children: [
                              PostTile(post: video),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                        childCount: videosList!.length,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(child: Icon(Icons.error));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }
}
