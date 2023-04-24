import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'course_video.g.dart';

@HiveType(typeId: 1)
class CourseVideo extends Equatable {
  @HiveField(6)
  final String? courseId;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? number;
  @HiveField(4)
  final String? link;

  const CourseVideo(
      {this.id, this.name, this.number, this.link, this.courseId});

  CourseVideo copyWith({
    String? id,
    String? name,
    String? number,
    String? link,
    String? courseId,
  }) {
    return CourseVideo(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      link: link ?? this.link,
      courseId: courseId ?? this.courseId,
    );
  }

  factory CourseVideo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseVideo(
      id: doc.id,
      name: data['name'] as String,
      number: data['num'] as String,
      link: data['link'] as String,
    );
  }

  factory CourseVideo.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseVideo(
      id: doc.id,
      name: data['name'] ?? '',
      number: data['num'] ?? '',
      link: data['video'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'num': number,
      'video': link,
    };
  }

  @override
  List<Object?> get props => [name, number, link, courseId];
}
