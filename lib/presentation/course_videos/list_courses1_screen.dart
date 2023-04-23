import 'package:coursesm/core/utils/enums/courses_type.dart';
import 'package:coursesm/data/models/course_model.dart';
import 'package:coursesm/presentation/course_videos/course_videos_viewmodel.dart';
import 'package:coursesm/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';

import '../../core/dependencies.dart';

class ListCourses1Screen extends StatefulWidget {
  final CourseModel course;
  final CoursesType coursesType;
  final String code;

  const ListCourses1Screen(
      {Key? key,
      required this.course,
      required this.coursesType,
      required this.code})
      : super(key: key);

  @override
  State<ListCourses1Screen> createState() => _ListCourses1ScreenState();
}

class _ListCourses1ScreenState extends State<ListCourses1Screen> {
  bool _disposed = false;
  @override
  void initState() {
    super.initState();
    sl<CourseVideosViewModel>().getCourseVideos(widget.course.id!, () {
      setState(() {});
    }, widget.coursesType);
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    sl<CourseVideosViewModel>().resetState(() {
      if (!_disposed) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: const Color(0xFF4097a6),
      ),
      body: Container(
        color: const Color(0xFF4097a6),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage('assets/images/camera.png'),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 290, top: 160),
                  child: const CircleAvatar(
                    maxRadius: 39,
                    backgroundColor: Color(0xFF4097a6),
                    child: CircleAvatar(
                      maxRadius: 35,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage('assets/images/play.png'),
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Builder(
              builder: (context) {
                if (sl<CourseVideosViewModel>().errorMessage.isNotEmpty) {
                  return const Center(
                    child: Text('خطا في جلب الفيديوهات'),
                  );
                }

                if (sl<CourseVideosViewModel>().isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (sl<CourseVideosViewModel>().videos.isNotEmpty) {
                  return ListView.builder(
                      itemCount: sl<CourseVideosViewModel>().videos.length,
                      itemBuilder: (context, index) {
                        final video = sl<CourseVideosViewModel>().videos[index];
                        return VideoCard(
                          video: video,
                          code: widget.code,
                          course: widget.course,
                        );
                      });
                } else {
                  return const Center(
                    child: Text('لا يوجد فيديوهات'),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
