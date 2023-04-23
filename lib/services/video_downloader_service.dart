import 'dart:io';

import 'package:coursesm/data/models/course_video.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class VideoDownloaderService {
  Future<String> downloadVideo(String url) async {
    try {
      const updatedUrl =
          'https://rr4---sn-p5qs7nzr.googlevideo.com/videoplayback?expire=1682312711&ei=p7lFZP-ABbuK_9EP5P-_wAk&ip=35.173.228.84&id=o-AJcvuD9Rc_orS3muTcseFfga0rEuFKoE8KlqzhB6Z1n5&itag=22&source=youtube&requiressl=yes&mh=RE&mm=31%2C26&mn=sn-p5qs7nzr%2Csn-t0a7sn7d&ms=au%2Conr&mv=m&mvi=4&pl=18&initcwndbps=898750&vprv=1&mime=video%2Fmp4&cnr=14&ratebypass=yes&dur=284.583&lmt=1471920760501603&mt=1682290612&fvip=4&fexp=24007246&c=ANDROID&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAJFdmo_HDoi3oz-9Nx_m6ewMTKfIUCeDC6KqbC79XwzEAiEA-sDPot-_x6Q-_453BqZT4JuLN5yZmkhn_JTPiegtlBw%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgaq80bSmOX05FZ2bj4AsyObqqRbpiLs5AkCeb9nBITkcCIQCGq3SGhzL6Mg6SNGW-ownJ4EadpYn-Munx85aS7MvUCA%3D%3D&title=Karim+Mohsen+++Makamelnash+++%D9%83%D8%B1%D9%8A%D9%85+%D9%85%D8%AD%D8%B3%D9%86+++%D9%85%D9%83%D9%85%D9%84%D9%86%D8%A7%D8%B4';
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(updatedUrl));
      final response = await request.close();

      final appDocDir = await getApplicationDocumentsDirectory();
      final file =
          File('${appDocDir.path}/${Uri.parse(updatedUrl).pathSegments.last}');
      await file
          .writeAsBytes(await consolidateHttpClientResponseBytes(response));

      // final ffmpeg = FlutterFFmpeg();
      // final outputPath = '${appDocDir.path}/converted.mp4';
      // final arguments = [
      //   '-i',
      //   file.path,
      //   '-c:v',
      //   'libx264',
      //   '-c:a',
      //   'copy',
      //   outputPath
      // ];
      // await ffmpeg.executeWithArguments(arguments);

      return file.path;
    } catch (err) {
      return '';
    }
  }

  Future<List<CourseVideo>> retrieveVideosFiles(
      List<CourseVideo> videoUrls) async {
    for (int index = 0; index < videoUrls.length; index++) {
      String filePath = await downloadVideo(videoUrls[index].link!);
      videoUrls[index] = videoUrls[index].copyWith(filePath: filePath);
    }

    return videoUrls;
  }
}
