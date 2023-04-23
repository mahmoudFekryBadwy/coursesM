import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'course_code.g.dart';

@HiveType(typeId: 2)
class CourseCode extends Equatable {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? code;
  @HiveField(3)
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

  @override
  List<Object?> get props => [code, uid];
}
