import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/core/api/firebase_api_provider.dart';
import 'package:coursesm/core/app_strings.dart';
import 'package:coursesm/core/utils/enums/courses_type.dart';
import 'package:coursesm/data/models/course_video.dart';

abstract class VideosRemoteRepository {
  Future<List<CourseVideo>> getCourseVideos(
      CoursesType coursesType,
      String
          courseId); // get videos for single course by its id from server (firestore)
}

class VideosRemoteRepositoryImpl implements VideosRemoteRepository {
  final FirebaseApiProvider firebaseApiProvider;

  VideosRemoteRepositoryImpl({required this.firebaseApiProvider});

  @override
  Future<List<CourseVideo>> getCourseVideos(
      CoursesType coursesType, String courseId) async {
    List<CourseVideo> videos = List.empty(growable: true);
    switch (coursesType) {
      case CoursesType.courses2:
        videos = await _handleFirestoreFetching(
            AppStrings.secondCoursesCollection, courseId);

        return videos;
      case CoursesType.courses3:
        videos = videos = await _handleFirestoreFetching(
            AppStrings.thirdCoursesCollection, courseId);

        return videos;
    }
  }

  Future<List<CourseVideo>> _handleFirestoreFetching(
      String collection, String docId) async {
    final response = await firebaseApiProvider.getSubCollectionData(
            collection, docId, AppStrings.videosSubCollection)
        as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

    return response.map((doc) => CourseVideo.fromQuerySnapshot(doc)).toList();
  }
}
