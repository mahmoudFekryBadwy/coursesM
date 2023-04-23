import 'dart:io';

import 'package:coursesm/data/models/course_model.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  final CourseVideo video;
  final CourseModel courseModel;
  final String code;

  const PlayVideoScreen({
    Key? key,
    required this.video,
    required this.courseModel,
    required this.code,
  }) : super(key: key);

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late YoutubePlayerController controller;
  late VideoPlayerController _videoController;

  bool isPlayerReady = false;

  void check(File file) async {
    bool found = await file.exists();
    print(found);
  }

  @override
  void initState() {
    super.initState();

    if (widget.video.filePath != null) {
      final path = File(widget.video.filePath!);
      // check(path);

      _videoController = VideoPlayerController.file(path)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      _videoController.play();
    } else {
      controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.video.link!)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          hideThumbnail: true,
        ),
      );
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    if (widget.video.filePath != null) {
      _videoController.pause();
    } else {
      controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (widget.video.filePath != null) {
      _videoController.pause();
    } else {
      controller.pause();
    }
    super.dispose();
  }

  late String videoId;
  @override
  Widget build(BuildContext context) {
    if (widget.video.filePath != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFF01153e),
          title: Text(
            widget.video.name!,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: Color(0xFF01153e),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    color: const Color(0xFF01153e),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(90)),
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 420,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      );
    } else {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: controller),
        builder: (p0, p1) => Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFF01153e),
            title: Text(
              widget.video.name!,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90)),
                        color: Color(0xFF01153e),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      color: const Color(0xFF01153e),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(90)),
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 420,
                        child: YoutubePlayer(controller: controller),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      );
    }
  }
}
