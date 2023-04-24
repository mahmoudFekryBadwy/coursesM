import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDownloaderService {
  Future<String> downloadVideo(String url) async {
    try {
      final YoutubeExplode youtubeExplode = YoutubeExplode();
      // get video metadata and path
      final video = await youtubeExplode.videos.get(url);
      final appDocDir = await getApplicationDocumentsDirectory();
      final file = File('${appDocDir.path}/${video.id}.mp4');

      var manifest = await youtubeExplode.videos.streamsClient.getManifest(url);

      var streams = manifest.muxed.withHighestBitrate();

      var stream = youtubeExplode.videos.streamsClient.get(streams);

      // delete file if exists
      if (file.existsSync()) {
        file.deleteSync();
      }
      final fileStream =
          file.openWrite(mode: FileMode.append); // open writing to file

      stream.pipe(fileStream).whenComplete(() async {
        // when file finishes close it
        await fileStream.flush();
        await fileStream.close();
      });
      return file.path;
    } catch (err) {
      return '';
    }
  }
}
