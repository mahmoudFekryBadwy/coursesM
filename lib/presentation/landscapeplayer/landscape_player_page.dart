import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LandScapePlayerPage extends StatefulWidget {
  const LandScapePlayerPage({Key? key,required this.controller}) : super(key: key);
  final VideoPlayerController controller;
  @override
  State<LandScapePlayerPage> createState() => _LandScapePlayerPageState();
}

class _LandScapePlayerPageState extends State<LandScapePlayerPage> {
  Future _landscapeMode()async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _setAllOrientation()async{
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _landscapeMode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _setAllOrientation();
  }
  @override
  Widget build(BuildContext context) {
    return  VideoPlayer(widget.controller);
  }
}
