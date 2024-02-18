import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  final String url;

  const PostVideoPlayer({super.key, required this.url});

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  late final VideoPlayerController videoPlayerController;
  bool isPlayed = false;
  bool isMuted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url))
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
    return Container(
      color: Colors.black,
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
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
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  if (isMuted == true) {
                    videoPlayerController.setVolume(0);
                  } else {
                    videoPlayerController.setVolume(100);
                  }
                  setState(() {
                    isMuted = !isMuted;
                  });
                },
                icon: Icon(
                  isMuted == false
                      ? Icons.volume_mute_outlined
                      : Icons.volume_down_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
