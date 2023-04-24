import 'package:coursesm/core/errors/exceptions.dart';
import 'package:coursesm/core/localstorage/localstorage_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService implements LocalStorageProvider {
  Future<void> init(String boxName) async {
    await Hive.initFlutter();
  }

  @override
  Future<T> getData<T>(String key, [String? boxName]) async {
    try {
      if (!Hive.isBoxOpen(boxName!)) {
        await Hive.openBox<T>(boxName);
      }
      final box = Hive.box<T>(boxName);

      final value = box.get(key);

      return value as T;
    } catch (err) {
      throw const CacheException();
    }
  }

  @override
  Future<void> setData<T>(String key, T value, [String? boxName]) async {
    try {
      if (!Hive.isBoxOpen(boxName!)) {
        await Hive.openBox<T>(boxName);
      }
      final box = Hive.box<T>(boxName);
      if (!box.containsKey(key)) {
        box.put(key, value);
      }
    } catch (err) {
      throw const CacheException();
    }
  }
}
