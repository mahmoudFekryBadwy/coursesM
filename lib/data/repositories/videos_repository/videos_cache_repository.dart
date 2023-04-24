import 'package:coursesm/core/app_strings.dart';
import 'package:coursesm/core/errors/exceptions.dart';
import 'package:coursesm/core/localstorage/localstorage_provider.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:hive/hive.dart';

abstract class VideosCacheRepository {
  Future<List<CourseVideo>> getCachedCourseVideos(
      String courseId); // get videos for single course by its id

  Future<void> cacheVideos(
      String courseId, CourseVideo video); // cahce videos by course id

  Future<String> getCachedVideoPath(String videoLink);

  Future<void> cacheVideoWithPath(String videoLink, String filePath);

  bool checkIfVideoIsCached(String videoLink);
}

class VideosCacheRepositoryImpl implements VideosCacheRepository {
  final LocalStorageProvider localStorageProvider;

  VideosCacheRepositoryImpl({required this.localStorageProvider});
  @override
  Future<void> cacheVideos(String courseId, CourseVideo video) async {
    try {
      // if box closed open it
      if (!Hive.isBoxOpen(AppStrings.videosKey)) {
        await Hive.openBox<CourseVideo>(AppStrings.videosKey);
      }
      final box = Hive.box<CourseVideo>(AppStrings.videosKey);

      if (!box.values.toList().contains(video)) {
        box.add(video);
      }
    } on CacheException catch (err) {
      throw err.message!;
    }
  }

  @override
  Future<List<CourseVideo>> getCachedCourseVideos(String courseId) async {
    List<CourseVideo> videos = List.empty(growable: true);
    try {
      // if box closed open it
      if (!Hive.isBoxOpen(AppStrings.videosKey)) {
        await Hive.openBox<CourseVideo>(AppStrings.videosKey);
      }
      final box = Hive.box<CourseVideo>(AppStrings.videosKey);

      if (box.values.isNotEmpty) {
        videos = box.values
            .where((element) => element.courseId == courseId)
            .toList();
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
