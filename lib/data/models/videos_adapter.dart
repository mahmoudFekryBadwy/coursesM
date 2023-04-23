import 'package:cloud_firestore/cloud_firestore.dart';

class VideosAdapter {
  List<String> convertFromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> json) {
    // convert from json to list of strings
    return json.map((e) => e.data().toString()).toList();
  }
}
