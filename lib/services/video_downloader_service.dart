import 'dart:io';

import 'package:coursesm/data/models/course_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDownloaderService {
  Future<String> downloadVideo(String url) async {
    try {
      final YoutubeExplode youtubeExplode = YoutubeExplode();

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
      final fileStream = file.openWrite(mode: FileMode.append);

      stream.pipe(fileStream).whenComplete(() async {
        await fileStream.flush();
        await fileStream.close();
      });
      return file.path;
      // // remove updated url when links are ready and optimized for downloading
      // const updatedUrl =
      //     'https://dl239.dlmate58.xyz/?file=M3R4SUNiN3JsOHJ6WWQ2a3NQS1Y5ZGlxVlZIOCtyaGh2STEvNWtObUpmSUovdHRxODd6bEF1Z0VhNE5XaU5Md1ZQb01zQitQTlBUVGRTNnY4N3grQjFIUXZKTVo0WHJ0cXNzRUFJd3BBbFBjd3FQN3ozb3pyVit3WDQrSU1lRVROU00raHhnbThnZlc2S21SbXpTOWx5VG8veG5HU0h4UGsyTkFlTkdJdEwwUmtFMlNLcSt3bHJSYzZIN0dxZDl0ZzdYRjUwVFNtdmRtN0pjd2Vod3hVckVZL2NLdy90U0pnUjljb2I5Wi9oVGg4Y1BqSXNad1BmTGJYVzgxSHdOTXpiYXFCRWhWOWdvcnMwMk0wK1FHejFBb1U0eFFveWVRb0xleE4zcThKNGV1YnRTZ2NxMmNnSURkdTd3NW5nVGwvNmFmeE5FRnNsRGlhZW02WW9sTmtHdG1oZnJHdloxejVnLzhnaTVmcHJoTTVobTVVeFY0RnJZQVpsTldZcFJDUWdwQTd1ekRySUprdUwwZEsyaTdwcDBTTXQ1azZNYWUvcXhKazM2eXZ0SXFaRXJENkgySlk1Ly9TRzBpOTJSMVF6ZkFBbGhHMms4bFJVL3gxdElsNnpic1hLODNOeHhkc1FHY1JDbURENGg1SWZiUXE1K0JlSG1Rdk5KWXpQQkdGazBXM3JUTnRnUlUzTkRGOGhtbnlZQ29kaVRuVU85b1JrZjNKSXUvOSszY1VQYjFVNVVnTkpUK2FlTmt0ejcvb3FmYkFYRGEyQT09';
      // final httpClient = HttpClient();
      // final request = await httpClient.getUrl(Uri.parse(updatedUrl));
      // final response = await request.close();

      // await file
      //     .writeAsBytes(await consolidateHttpClientResponseBytes(response));

      // return file.path;
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
