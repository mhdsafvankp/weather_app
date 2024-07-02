import 'package:hive/hive.dart';


/// A generic class for Hive Helper
///
/// openBox by [init] function
///
/// save by [saveData] function
///
/// get by [getData] function
class HiveService<T>{

  final String boxName;

  HiveService(this.boxName);

  Future<void> init() async {
    await Hive.openBox<T>(boxName);
  }

  Future<void> saveData(String key, T data) async {
    var box = Hive.box<T>(boxName);
    await box.put(key, data);
  }

  T? getData(String key) {
    var box = Hive.box<T>(boxName);
    return box.get(key);
  }

}
