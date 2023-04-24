import 'package:coursesm/data/models/course_model.dart';
import 'package:coursesm/data/models/course_video.dart';
import 'package:flutter/material.dart';

import '../video/play_video_screeen.dart';

class VideoCard extends StatelessWidget {
  final CourseVideo video;
  final String code;
  final CourseModel course;
  const VideoCard(
      {super.key,
      required this.video,
      required this.code,
      required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlayVideoScreen(
                  video: video,
                  courseModel: course,
                  code: code,
                )));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "0${video.number}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  video.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  maxLines: 3,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
