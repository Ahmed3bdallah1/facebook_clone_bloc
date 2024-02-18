import 'package:facebook_clone_bloc/features/posts/models/post_model.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/image_video_widgets/view_post_image_or_video.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/post_widgets/post_tile_info.dart';
import 'package:flutter/material.dart';
import 'like_comment_share_item.dart';
import 'likes.dart';

class PostTile extends StatelessWidget {
  final PostModel post;
  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        PostTileInfo(
          datePublished: post.createdAt,
          userId: post.userId,
        ),
        // Post Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(post.post,style: const TextStyle(fontSize: 16),),
        ),
        // Post Video / Image
        Center(
          child: ViewPostImagesOrVideo(
            url: post.fileUrl,
            fileType: post.postType,
          ),
        ),

        // Likes and comment buttons
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          child: Column(
            children: [
              // Likes
              Likes(likes: post.likes),
              const Divider(),
              LikeCommentShare(post: post),
            ],
          ),
        )
      ],
    );
  }
}
