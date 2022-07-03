import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final String videoUrl;
  final String imageUrl;
  final bool playVideo;

  const VideoTile({
    Key? key,
    required this.videoUrl,
    required this.playVideo,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl);
    initializeVideoPlayerFuture = controller.initialize();

    if (widget.playVideo) {
      controller.play();
      controller.setVolume(0.0);
      controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoTile oldWidget) {
    if (oldWidget.playVideo != widget.playVideo) {
      if (widget.playVideo) {
        controller.play();
        controller.setVolume(0.0);
        controller.setLooping(true);
      } else {
        controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.playVideo
        ? FutureBuilder(
            future: initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        : Image(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.fill,
          );
  }
}
