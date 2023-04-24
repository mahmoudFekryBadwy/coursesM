// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/core/api/firebase_api_provider.dart';
import 'package:coursesm/core/services/base_service.dart';

import '../errors/exceptions.dart';

class FirebaseApiConsumer implements FirebaseApiProvider {
  final BaseServise baseServise;

  FirebaseApiConsumer({required this.baseServise});
  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getData(
      String collection) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    try {
      // get all data from collection
      await baseServise.fireStore
          .collection(collection)
          .get()
          .then((value) => data = value.docs);
      return data;
    } catch (err) {
      throw const ServerException();
    }
  }

  @override
  Future getDataByDocId(String collection, String docId) async {
    try {
      // get single documnet by do ic
      final response =
          await baseServise.fireStore.collection(collection).doc(docId).get();

      return response;
    } catch (err) {
      throw const ServerException();
    }
  }

  @override
  Future getDataByID(String collection, String attribute, String id) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    try {
      // get all data that matches id
      await baseServise.fireStore
          .collection(collection)
          .where(attribute, isEqualTo: id)
          .get()
          .then((value) => data = value.docs);
      return data;
    } catch (err) {
      throw const ServerException();
    }
  }

  @override
  Future getSubCollectionData(
      String collection, String docId, String subCollection) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    // get subcollection data for given docId
    try {
      await baseServise.fireStore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .get()
          .then((value) => data = value.docs);

      return data;
    } catch (err) {
      throw const ServerException();
    }
  }

  @override
  Future getSubCollectionDataWithOrder(String collection, String docId,
      String subCollection, String orderBy) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    // get subcollection data for given docId with ordering
    try {
      await baseServise.fireStore
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .orderBy(orderBy, descending: false)
          .get()
          .then((value) => data = value.docs);

      return data;
    } catch (err) {
      throw const ServerException();
    }
  }
}
