abstract class FirebaseApiProvider {
  Future getDataByID(String collection, String attribute, String id);
  Future getDataByDocId(String collection, String docId);
  Future getData(String collection);
  Future getSubCollectionData(
      String collection, String docId, String subCollection);
  Future getSubCollectionDataWithOrder(
      String collection, String docId, String subCollection, String orderBy);
}
