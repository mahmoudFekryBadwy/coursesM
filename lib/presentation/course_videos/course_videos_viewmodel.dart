import 'package:coursesm/core/utils/enums/courses_type.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_repository.dart';

class CourseVideosViewModel {
  final VideosRepository videosRepository;
  List<CourseVideo> _vidoes = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CourseVideosViewModel({required this.videosRepository});

  List<CourseVideo> get videos => _vidoes;

  void getCourseVideos(String courseId, Function setStateCallback,
      CoursesType coursesType) async {
    final response =
        await videosRepository.getCourseVideos(coursesType, courseId);
    _vidoes = List.from(response);
    _isLoading = false;
    // update state
    setStateCallback();
  }

  void resetState(Function setStateCallback) {
    _vidoes = List.empty(growable: true);
    _errorMessage = '';
    _isLoading = true;
    setStateCallback();
  }
}
