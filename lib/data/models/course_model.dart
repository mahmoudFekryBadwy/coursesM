import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  String? id;
  String? name;
  int? date;
  List<String>? videos;
  List<String>? codes;

  CourseModel({this.id, this.name, this.date, this.videos, this.codes});

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
      'videos': videos,
    };
  }

  CourseModel copyWith({
    String? id,
    String? name,
    int? date,
    List<String>? videos,
    List<String>? codes,
  }) {
    return CourseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        videos: videos ?? this.videos,
        codes: codes ?? this.codes);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, date, videos, codes];
}
