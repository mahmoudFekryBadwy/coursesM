import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  final docid;
  final list;
  final name;
  final code;

  const PlayVideoScreen({Key? key, this.docid,this.list,this.name,this.code}) : super(key: key);

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {


  late YoutubePlayerController controller;
  bool isPlayerReady = false;
  @override
  void initState(){
    super.initState();
    var url = widget.list;
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
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
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late String videoId;
  @override
  Widget build(BuildContext context)=>YoutubePlayerBuilder(
    player: YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
    ),
    builder: (context,player) => Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF01153e),
        title: Text(widget.name,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child:
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: Color(0xFF01153e),
                  ),
                ),
              ],
            ),
            Expanded(child: Stack(
              children: [
                Container(
                  color: const Color(0xFF01153e),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 420,
                    child:player,
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
