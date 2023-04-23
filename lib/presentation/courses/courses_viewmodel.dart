import 'package:coursesm/data/repositories/courses_repository/courses_repository.dart';

import '../../data/models/course_model.dart';

class CoursesViewModel {
  final CoursesRepository coursesRepository;
  List<CourseModel> _courses = [];

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CoursesViewModel({required this.coursesRepository});

  List<CourseModel> get courses => _courses;

  void getCourses(int courseNum) async {
    final response = await coursesRepository.getCourses(courseNum);

    // if success return courses
    response.fold((failure) => _errorMessage = failure.message, (courses) {
      _courses = List.from(courses);
      _errorMessage = '';
    });
  }

  void resetState() {
    _courses = List.empty(growable: true);
    _errorMessage = '';
  }
}
