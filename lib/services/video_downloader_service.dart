import 'dart:io';

import 'package:coursesm/data/models/course_video.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class VideoDownloaderService {
  Future<String> downloadVideo(String url) async {
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();

    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocDir.path}/${Uri.parse(url).pathSegments.last}');
    await file.writeAsBytes(await consolidateHttpClientResponseBytes(response));

    return file.path;
  }

  Future<List<CourseVideo>> retrieveVideosFiles(
      List<CourseVideo> videoUrls) async {
    for (CourseVideo video in videoUrls) {
      String filePath = await downloadVideo(video.link!);
      video.copyWith(filePath: filePath);
    }

    return videoUrls;
  }
}
