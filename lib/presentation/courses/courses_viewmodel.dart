import 'package:coursesm/data/repositories/courses_repository/courses_repository.dart';

import '../../data/models/course_model.dart';

class CoursesViewModel {
  final CoursesRepository coursesRepository;
  List<CourseModel> _courses = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CoursesViewModel({required this.coursesRepository});

  List<CourseModel> get courses => _courses;

  void getCourses(int courseNum, Function setStateCallback) async {
    final response = await coursesRepository.getCourses(courseNum);

    // if success return courses
    response.fold((failure) => _errorMessage = failure.message, (courses) {
      _courses = List.from(courses);
      _errorMessage = '';
    });

    _isLoading = false;
    // update state
    setStateCallback();
  }

  void resetState(Function setStateCallback) {
    _courses = List.empty(growable: true);
    _errorMessage = '';
    _isLoading = true;
    setStateCallback();
  }
}
