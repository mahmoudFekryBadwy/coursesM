import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/core/api/firebase_api_provider.dart';
import 'package:coursesm/core/app_strings.dart';
import 'package:coursesm/core/errors/exceptions.dart';
import 'package:coursesm/core/errors/faliures.dart';
import 'package:coursesm/data/models/course_model.dart';
import 'package:dartz/dartz.dart';

abstract class CoursesRepository {
  Future<Either<Failure, List<CourseModel>>> getCourses(int courseNum);
}

class CoursesRepositoryImpl implements CoursesRepository {
  final FirebaseApiProvider firebaseApiProvider;

  CoursesRepositoryImpl({required this.firebaseApiProvider});

  Future<List<CourseModel>> _handleCourseConvertion(String collection) async {
    final response =
        await firebaseApiProvider.getData(AppStrings.secondCoursesCollection)
            as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

    return response
        .map((value) => CourseModel.fromFirestore(querySnap: value))
        .toList();
  }

  @override
  Future<Either<Failure, List<CourseModel>>> getCourses(int courseNum) async {
    try {
      // get courses based on course num
      switch (courseNum) {
        case 2:
          return Right(await _handleCourseConvertion(
              AppStrings.secondCoursesCollection));
        case 3:
          return Right(
              await _handleCourseConvertion(AppStrings.thirdCoursesCollection));
        default:
          return const Right([]);
      }
    } on ServerException catch (err) {
      // if failed return failure
      throw ServerFailure(message: err.message!);
    }
  }
}
