import 'package:coursesm/core/errors/exceptions.dart';
import 'package:coursesm/core/localstorage/localstorage_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService implements LocalStorageProvider {
  Future<void> init(String boxName) async {
    await Hive.initFlutter();
  }

  @override
  Future<T> getData<T>(String key) async {
    try {
      if (Hive.isBoxOpen(key)) {
        Hive.openBox<T>(key);
      }
      final box = Hive.box<T>(key);
      return box.get(key) as T;
    } catch (err) {
      throw const CacheException();
    }
  }

  @override
  Future<void> setData<T>(String key, T value) async {
    try {
      if (Hive.isBoxOpen(key)) {
        Hive.openBox<T>(key);
      }
      final box = Hive.box<T>(key);
      if (!box.containsKey(key)) {
        box.put(key, value);
      }
    } catch (err) {
      throw const CacheException();
    }
  }
}
