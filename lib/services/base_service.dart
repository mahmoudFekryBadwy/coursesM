import 'package:cloud_firestore/cloud_firestore.dart';

class BaseServise {
  final _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get fireStore => _firestore;
}
