import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class videoplayer extends StatefulWidget {
  String path;
  videoplayer({super.key, required this.path});

  @override
  State<videoplayer> createState() => _videoplayerState();
}

class _videoplayerState extends State<videoplayer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  Future initializeVideo() async {
    videoPlayerController = VideoPlayerController.network(widget.path).play()
        as VideoPlayerController?;

    await videoPlayerController?.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('Option 1 pressed!'),
            iconData: Icons.chat,
            title: 'Option 1',
          ),
          OptionItem(
            onTap: () => debugPrint('Option 2 pressed!'),
            iconData: Icons.share,
            title: 'Option 2',
          ),
        ];
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playvid"),
      ),
      body: Container(
        height: 250,
        child: chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized
            ? Container(
                height: 250,
                child: Chewie(
                  controller: chewieController!,
                ),
              )
            : Container(
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
