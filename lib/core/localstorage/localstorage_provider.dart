abstract class LocalStorageProvider {
  Future<T> getData<T>(String key);
  Future<void> setData<T>(String key, T value);
}
