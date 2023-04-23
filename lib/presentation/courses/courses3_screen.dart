import 'package:flutter/material.dart';

import '../../core/dependencies.dart';
import '../widgets/course_card.dart';
import 'courses_viewmodel.dart';

class Courses3Screen extends StatefulWidget {
  const Courses3Screen({Key? key}) : super(key: key);

  @override
  State<Courses3Screen> createState() => _Courses3ScreenState();
}

class _Courses3ScreenState extends State<Courses3Screen> {
  var code;
  var id;
  List tikenid = [];
  var codeController = TextEditingController();
  var codeId;
  var model;
  var uId;

  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    sl<CoursesViewModel>().getCourses(3, () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _disposed = true;
    sl<CoursesViewModel>().resetState(() {
      if (!_disposed) {
        setState(() {}); // update the state of the widget
      }
    });
    super.dispose();
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
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                  color: Colors.white),
              child: Column(
                children: const [
                  Center(
                    child: Text(
                      'الفرقة الثالثة',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Builder(
                builder: (
                  context,
                ) {
                  if (sl<CoursesViewModel>().isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  if (sl<CoursesViewModel>().errorMessage.isNotEmpty) {
                    return Text(sl<CoursesViewModel>().errorMessage);
                  }
                  if (sl<CoursesViewModel>().courses.isNotEmpty) {
                    return ListView.builder(
                        itemCount: sl<CoursesViewModel>().courses.length,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        itemExtent: 120,
                        itemBuilder: (context, index) {
                          final course = sl<CoursesViewModel>().courses[index];
                          return CourseCard(course: course);
                        });
                  } else {
                    return const Center(
                      child: Text('لا يوجد كورسات'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
