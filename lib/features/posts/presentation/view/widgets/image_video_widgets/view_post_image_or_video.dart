import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/image_video_widgets/post_video_player.dart';
import 'package:flutter/material.dart';

class ViewPostImagesOrVideo extends StatelessWidget {
  final String fileType;
  final String url;

  const ViewPostImagesOrVideo(
      {super.key, required this.fileType, required this.url});

  @override
  Widget build(BuildContext context) {
    if (fileType == "image") {
      return CachedNetworkImage(
        imageUrl: url,
        height: 300,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      return PostVideoPlayer(url: url);
    }
  }
}
