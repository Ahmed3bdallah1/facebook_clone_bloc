import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController videoPlayerController;
  bool isPlayed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Positioned(
            bottom: 0,
            top: 0,
            right: 0,
            left: 0,
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                if (isPlayed == false) {
                  videoPlayerController.play();
                } else {
                  videoPlayerController.pause();
                }
                setState(() {
                  isPlayed = !isPlayed;
                });
              },
              icon: Icon(
                isPlayed == false ? Icons.play_circle : Icons.pause_circle,
                size: 50,
                color: isPlayed == false ? Colors.white : Colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
