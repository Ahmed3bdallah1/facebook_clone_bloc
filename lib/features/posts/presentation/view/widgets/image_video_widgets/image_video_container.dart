import 'dart:io';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/image_video_widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

class ImageVideoContainer extends StatelessWidget {
  final String fileType;
  final File file;

  const ImageVideoContainer({
    super.key,
    required this.fileType,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    if (fileType == "image") {
      return Image.file(file);
    }else{
      return VideoPlayerWidget(file: file,);
    }
  }
}
