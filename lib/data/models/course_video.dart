import 'package:cloud_firestore/cloud_firestore.dart';

class CourseVideo {
  String? id;
  String? name;
  String? number;
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
      name: data['name'] as String,
      number: data['num'] as String,
      link: data['link'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'num': number,
      'link': link,
    };
  }
}
