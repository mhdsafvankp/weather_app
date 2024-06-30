class WeatherModel {
  final Main main;
  final Wind wind;
  final Sys sys;
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

class Main {
  final double temp;
  final int humidity;
  final double tempMin;
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

class Sys {
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

class Wind {
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
