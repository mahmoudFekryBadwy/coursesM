import 'package:coursesm/data/models/course_video.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_cache_repository.dart';
import 'package:coursesm/core/services/connectivity_service.dart';
import 'package:coursesm/core/services/video_downloader_service.dart';

class PlayVideoViewModel {
  final VideosCacheRepository videosCacheRepository;
  final VideoDownloaderService videoDownloaderService;
  final ConnectivityService connectivityService;

  bool _isLoading = true;
  bool _isConnected = true;
  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  PlayVideoViewModel({
    required this.videosCacheRepository,
    required this.connectivityService,
    required this.videoDownloaderService,
  });

  void setIsConnected(bool value, Function setStateCallBack) {
    _isConnected = value;
    setStateCallBack();
  }

  void handleVideoCaching(CourseVideo video, Function setStateCallback) async {
    final isVideoCached =
        videosCacheRepository.checkIfVideoIsCached(video.link!);

    // if storage is empty download video then store it
    if (!isVideoCached) {
      final videoPath = await videoDownloaderService.downloadVideo(video.link!);
      videosCacheRepository.cacheVideoWithPath(video.link!, videoPath);
    }
  }

  void handleLoadingState(Function setStateCallback) async {
    _isLoading = false;
    setStateCallback();
  }

  Future<String> getCachedVideoPath(String videoLink) async {
    return await videosCacheRepository.getCachedVideoPath(videoLink);
  }

  void resetState(Function setStateCallback) {
    _errorMessage = '';
    _isLoading = true;
    setStateCallback();
  }
}
