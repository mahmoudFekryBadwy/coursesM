import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'course_video.g.dart';

@HiveType(typeId: 1)
class CourseVideo extends Equatable {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? number;
  @HiveField(4)
  String? link;

  CourseVideo({
    required this.id,
    required this.name,
    required this.number,
    required this.link,
  });

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
  List<Object?> get props => [name, number, link];
}
