import 'package:coursesm/core/utils/enums/courses_type.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_cache_repository.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_remote_repository.dart';
import 'package:coursesm/core/services/connectivity_service.dart';

import '../../../core/services/video_downloader_service.dart';

abstract class VideosRepository {
  Future<List<CourseVideo>> getCourseVideos(
      CoursesType coursesType, String courseDocId);
}

class VideosRepositoryImpl implements VideosRepository {
  final VideosCacheRepository videosCacheRepository;
  final VideosRemoteRepository videosRemoteRepository;
  final ConnectivityService connectivityService;
  final VideoDownloaderService videoDownloaderService;

  VideosRepositoryImpl(
      {required this.videosCacheRepository,
      required this.videoDownloaderService,
      required this.connectivityService,
      required this.videosRemoteRepository});

  @override
  Future<List<CourseVideo>> getCourseVideos(
      CoursesType coursesType, String courseDocId) async {
    List<CourseVideo> videos = List.empty(growable: true);
    try {
      bool isConnected = await connectivityService.checkInternetConnection();

      if (isConnected) {
        videos = await videosRemoteRepository.getCourseVideos(
            coursesType, courseDocId);
        // get videos from firestore

        await videosCacheRepository.cacheVideos(
            courseDocId, {courseDocId: videos}); // cache videos details
      } else {
        // if failed fetch from cahce
        videos = await videosCacheRepository.getCachedCourseVideos(courseDocId);
      }

      return videos;
    } catch (err) {
      return videos;
    }
  }
}
