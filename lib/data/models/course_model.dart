import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  final String? id;
  final String? name;
  final int? date;

  const CourseModel({
    this.id,
    this.name,
    this.date,
  });

  factory CourseModel.fromFirestore(
      {DocumentSnapshot<Map<String, dynamic>>? docSnap,
      QueryDocumentSnapshot<Map<String, dynamic>>? querySnap}) {
    if (docSnap != null) {
      return CourseModel(
        id: docSnap.id,
        name: docSnap.data()!['name'] ?? '',
        date: docSnap.data()!['date'] ?? 0,
      );
    } else {
      return CourseModel(
        id: querySnap!.id,
        name: querySnap.data()['name'] ?? '',
        date: querySnap.data()['date'] ?? 0,
      );
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'date': date,
    };
  }

  CourseModel copyWith({
    String? id,
    String? name,
    int? date,
  }) {
    return CourseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, name, date];
}
