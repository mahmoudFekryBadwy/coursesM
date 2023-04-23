import 'package:coursesm/core/api/firebase_api_consumer.dart';
import 'package:coursesm/core/api/firebase_api_provider.dart';
import 'package:coursesm/data/repositories/courses_repository/courses_repository.dart';
import 'package:coursesm/presentation/courses/courses_viewmodel.dart';
import 'package:coursesm/services/base_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // register dependicnies that will be used in app
  // lazy singeleton for better resource managment

  sl.registerLazySingleton(() => BaseServise());
  sl.registerLazySingleton<FirebaseApiProvider>(
      () => FirebaseApiConsumer(baseServise: sl()));
  sl.registerLazySingleton<CoursesRepository>(
      () => CoursesRepositoryImpl(firebaseApiProvider: sl()));

  sl.registerLazySingleton(() => CoursesViewModel(coursesRepository: sl()));
}
