import 'package:coursesm/core/app_strings.dart';
import 'package:coursesm/core/dependencies.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:coursesm/presentation/splash/splash_screen.dart';
import 'package:coursesm/core/services/db_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/models/course_code.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDb();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // init hive for local storage
  await Hive.initFlutter();

  Hive.registerAdapter(CourseVideoAdapter());
  Hive.registerAdapter(CourseCodeAdapter());
  await Hive.openBox<Map<String, List<CourseVideo>>>(
      AppStrings.videosKey); //  box  for storing and caching videos
  await Hive.openBox<List<CourseCode>>(
      AppStrings.codesKey); //  box  for storing and caching codes

  await Hive.openBox<String>(
      AppStrings.videosPathsKey); // box for videos file paths

  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
