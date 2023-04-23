import 'package:cloud_firestore/cloud_firestore.dart';

class CourseCode {
  String? id;
  String? code;
  String? uid;

  CourseCode({
    required this.id,
    required this.code,
    required this.uid,
  });

  factory CourseCode.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseCode(
      id: doc.id,
      code: data['code'] as String,
      uid: data['uid'] as String,
    );
  }

  factory CourseCode.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseCode(
      id: doc.id,
      code: data['code'] as String,
      uid: data['uid'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'code': code,
      'uid': uid,
    };
  }
}
