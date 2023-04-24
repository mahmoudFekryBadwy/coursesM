import 'package:coursesm/core/api/firebase_api_consumer.dart';
import 'package:coursesm/core/api/firebase_api_provider.dart';
import 'package:coursesm/core/localstorage/localstorage_provider.dart';
import 'package:coursesm/data/repositories/courses_repository/courses_repository.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_cache_repository.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_remote_repository.dart';
import 'package:coursesm/data/repositories/videos_repository/videos_repository.dart';
import 'package:coursesm/presentation/course_videos/course_videos_viewmodel.dart';
import 'package:coursesm/presentation/courses/courses_viewmodel.dart';
import 'package:coursesm/presentation/video/play_video_viewmodel.dart';
import 'package:coursesm/services/base_service.dart';
import 'package:coursesm/services/connectivity_service.dart';
import 'package:coursesm/services/video_downloader_service.dart';
import 'package:get_it/get_it.dart';

import 'localstorage/hive_consumer.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // register dependicnies that will be used in app
  // lazy singeleton for better resource managment

  sl.registerLazySingleton(() => BaseServise());
  sl.registerLazySingleton(() => ConnectivityService());
  sl.registerLazySingleton(() => VideoDownloaderService());
  sl.registerLazySingleton<LocalStorageProvider>(() => HiveStorageService());
  sl.registerLazySingleton<FirebaseApiProvider>(
      () => FirebaseApiConsumer(baseServise: sl()));
  sl.registerLazySingleton<CoursesRepository>(
      () => CoursesRepositoryImpl(firebaseApiProvider: sl()));

  sl.registerLazySingleton<VideosCacheRepository>(
      () => VideosCacheRepositoryImpl(localStorageProvider: sl()));

  sl.registerLazySingleton<VideosRemoteRepository>(
      () => VideosRemoteRepositoryImpl(firebaseApiProvider: sl()));

  sl.registerLazySingleton<VideosRepository>(() => VideosRepositoryImpl(
      videoDownloaderService: sl(),
      videosCacheRepository: sl(),
      videosRemoteRepository: sl(),
      connectivityService: sl()));

  sl.registerLazySingleton(() => CoursesViewModel(coursesRepository: sl()));
  sl.registerLazySingleton(() => CourseVideosViewModel(videosRepository: sl()));
  sl.registerLazySingleton(() => PlayVideoViewModel(
      connectivityService: sl(),
      videoDownloaderService: sl(),
      videosCacheRepository: sl()));
}
