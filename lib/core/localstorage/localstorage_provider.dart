abstract class LocalStorageProvider {
  Future<T> getData<T>(String key, [String boxName]);
  Future<void> setData<T>(String key, T value, [String boxName]);
}
