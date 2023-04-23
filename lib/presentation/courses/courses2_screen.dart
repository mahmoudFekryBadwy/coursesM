import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/core/dependencies.dart';
import 'package:coursesm/presentation/courses/courses_viewmodel.dart';
import 'package:coursesm/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';

class Courses2Screen extends StatefulWidget {
  const Courses2Screen({Key? key}) : super(key: key);

  @override
  State<Courses2Screen> createState() => _Courses2ScreenState();
}

class _Courses2ScreenState extends State<Courses2Screen> {
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
    sl<CoursesViewModel>().getCourses(2, () {
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

  CollectionReference courses2 =
      FirebaseFirestore.instance.collection("courses2");

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
                      'الفرقة الثانية',
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
