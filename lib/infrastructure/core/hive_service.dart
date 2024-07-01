import 'package:hive/hive.dart';
import 'package:weather_app/domain/common/logger.dart';


/// A generic class for Hive Helper
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
