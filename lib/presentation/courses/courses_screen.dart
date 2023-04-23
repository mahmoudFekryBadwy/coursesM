import 'package:coursesm/core/dependencies.dart';
import 'package:coursesm/core/utils/enums/courses_type.dart';
import 'package:coursesm/presentation/courses/courses_viewmodel.dart';
import 'package:coursesm/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  final CoursesType coursesType;
  const CoursesScreen({Key? key, required this.coursesType}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List tikenid = [];
  var codeController = TextEditingController();

  bool _disposed = false;

  void _handleFetchCourses(CoursesType coursesType) {
    // fetch courses based on courses type (2 or 3)
    switch (coursesType) {
      case CoursesType.courses2:
        return sl<CoursesViewModel>().getCourses(2, () {
          setState(() {});
        });
      case CoursesType.courses3:
        return sl<CoursesViewModel>().getCourses(3, () {
          setState(() {});
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleFetchCourses(widget.coursesType);
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
                children: [
                  Center(
                    child: Text(
                      widget.coursesType == CoursesType.courses2
                          ? 'الفرقة الثانية'
                          : 'الفرقة الثالثة',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
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
                          return CourseCard(
                            course: course,
                            coursesType: widget.coursesType,
                          );
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
