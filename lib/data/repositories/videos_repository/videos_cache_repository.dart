import 'package:coursesm/core/app_strings.dart';
import 'package:coursesm/core/errors/exceptions.dart';
import 'package:coursesm/core/localstorage/localstorage_provider.dart';
import 'package:coursesm/data/models/course_video.dart';

abstract class VideosCacheRepository {
  Future<List<CourseVideo>> getCachedCourseVideos(
      String courseId); // get videos for single course by its id

  Future<void> cacheVideos(
      String courseId, List<CourseVideo> videos); // cahce videos by course id
}

class VideosCacheRepositoryImpl implements VideosCacheRepository {
  final LocalStorageProvider localStorageProvider;

  VideosCacheRepositoryImpl({required this.localStorageProvider});
  @override
  Future<void> cacheVideos(String courseId, List<CourseVideo> videos) async {
    try {
      await localStorageProvider.setData<List<CourseVideo>>(
          courseId, videos, AppStrings.videosKey);
    } on CacheException catch (err) {
      throw err.message!;
    }
  }

  @override
  Future<List<CourseVideo>> getCachedCourseVideos(String courseId) async {
    List<CourseVideo> videos = List.empty(growable: true);
    try {
      final result = await localStorageProvider.getData<List<CourseVideo>>(
          courseId, AppStrings.videosKey);
      videos = result;
      return videos;
    } on CacheException {
      return videos;
    }
  }
}
