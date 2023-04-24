import 'package:coursesm/core/app_strings.dart';
import 'package:coursesm/core/errors/exceptions.dart';
import 'package:coursesm/core/localstorage/localstorage_provider.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:hive/hive.dart';

abstract class VideosCacheRepository {
  Future<List<CourseVideo>> getCachedCourseVideos(
      String courseId); // get videos for single course by its id

  Future<void> cacheVideos(String courseId,
      Map<String, List<CourseVideo>> videos); // cahce videos by course id

  Future<String> getCachedVideoPath(String videoLink);

  Future<void> cacheVideoWithPath(String videoLink, String filePath);

  bool checkIfVideoIsCached(String videoLink);
}

class VideosCacheRepositoryImpl implements VideosCacheRepository {
  final LocalStorageProvider localStorageProvider;

  VideosCacheRepositoryImpl({required this.localStorageProvider});
  @override
  Future<void> cacheVideos(
      String courseId, Map<String, List<CourseVideo>> videos) async {
    try {
      await localStorageProvider.setData<Map<String, List<CourseVideo>>>(
          courseId, videos, AppStrings.videosKey);
    } on CacheException catch (err) {
      throw err.message!;
    }
  }

  @override
  Future<List<CourseVideo>> getCachedCourseVideos(String courseId) async {
    List<CourseVideo> videos = List.empty(growable: true);
    try {
      final result =
          await localStorageProvider.getData<Map<String, List<CourseVideo>>>(
              courseId, AppStrings.videosKey);
      if (result[courseId] != null) {
        videos = result[courseId]!;
      }
      return videos;
    } on CacheException {
      return videos;
    }
  }

  @override
  Future<String> getCachedVideoPath(String videoLink) async {
    try {
      final result = await localStorageProvider.getData<String>(
          videoLink, AppStrings.videosPathsKey);

      return result;
    } on CacheException {
      return '';
    }
  }

  @override
  Future<void> cacheVideoWithPath(String videoLink, String filePath) async {
    try {
      await localStorageProvider.setData<String>(
          videoLink,
          filePath,
          AppStrings
              .videosPathsKey); // save video file path as value and link as key
    } on CacheException catch (err) {
      throw err.message!;
    }
  }

  @override
  bool checkIfVideoIsCached(String videoLink) {
    return Hive.box<String>(AppStrings.videosPathsKey).containsKey(videoLink);
  }
}
