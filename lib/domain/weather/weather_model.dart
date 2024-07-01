import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel {
  @HiveField(0)
  final Main main;

  @HiveField(1)
  final Wind wind;

  @HiveField(2)
  final Sys sys;

  @HiveField(3)
  final String name;

  WeatherModel({
    required this.main,
    required this.wind,
    required this.sys,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        sys: Sys.fromJson(json["sys"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "wind": wind.toJson(),
        "sys": sys.toJson(),
        "name": name,
      };
}

@HiveType(typeId: 1)
class Main {
  @HiveField(0)
  final double temp;

  @HiveField(1)
  final int humidity;

  @HiveField(2)
  final double tempMin;

  @HiveField(3)
  final double tempMax;

  Main({
    required this.temp,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        humidity: json["humidity"],
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "humidity": humidity,
        "temp_min": tempMin,
        "temp_max": tempMax,
      };
}

@HiveType(typeId: 2)
class Sys {
  @HiveField(0)
  final String country;

  Sys({
    required this.country,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}

@HiveType(typeId: 3)
class Wind {
  @HiveField(0)
  final double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
      };
}
