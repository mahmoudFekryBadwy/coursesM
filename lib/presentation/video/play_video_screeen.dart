// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:coursesm/core/dependencies.dart';
import 'package:coursesm/data/models/course_model.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:coursesm/presentation/video/play_video_viewmodel.dart';
import 'package:coursesm/core/services/connectivity_service.dart';
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
  late YoutubePlayerController _controller;
  late VideoPlayerController _videoController;

  bool isPlayerReady = false;
  bool _disposed = false;

  void handleDisposing(Function setStateCallback) {
    if (!sl<PlayVideoViewModel>().isConnected) {
      _videoController.dispose();
    }

    _controller.dispose();
    sl<PlayVideoViewModel>().resetState(setStateCallback);
  }

  void handleDeactivating() {
    if (!sl<PlayVideoViewModel>().isConnected) {
      _videoController.pause();
    }

    _controller.pause();
  }

  void handleonCourseInit() async {
    bool isConnected =
        await sl<ConnectivityService>().checkInternetConnection();

    sl<PlayVideoViewModel>().setIsConnected(isConnected, () {
      setState(() {});
    });

    if (!isConnected) {
      // if no internet connection load file from cache
      final videoPath =
          await sl<PlayVideoViewModel>().getCachedVideoPath(widget.video.link!);

      _videoController = VideoPlayerController.file(File(videoPath))
        ..initialize().then((value) {});
      _videoController.play();
    } else {
      // if internet connection download video and cache it
      sl<PlayVideoViewModel>().handleVideoCaching(widget.video, () {
        setState(() {});
      });
    }

    _controller = YoutubePlayerController(
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
    isPlayerReady = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    handleonCourseInit();
  }

  @override
  void deactivate() {
    handleDeactivating();
    super.deactivate();
  }

  @override
  void dispose() {
    _disposed = true;
    handleDisposing(() {
      if (!_disposed) {
        setState(() {}); // update the state of the widget
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                // if connected load from youtube
                sl<PlayVideoViewModel>().isConnected
                    ? isPlayerReady
                        ? YoutubePlayerBuilder(
                            player: YoutubePlayer(controller: _controller),
                            builder: (context, _) {
                              return Center(
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 420,
                                    child:
                                        YoutubePlayer(controller: _controller)),
                              );
                            })
                        : const SizedBox()

                    // if not connected load from video player (cache file)
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 420,
                          child: isPlayerReady
                              ? VideoPlayer(_videoController)
                              : Container(),
                        ),
                      )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
