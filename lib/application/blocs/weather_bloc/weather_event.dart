
import '../../../domain/weather/weather_model.dart';

abstract class WeatherEvent{}

class LoadWeatherScreen extends WeatherEvent{
}


class LoadPreDefinedLocations extends WeatherEvent{}


class WeatherSearchEvent extends WeatherEvent{
  final String query;
  WeatherSearchEvent({required this.query});
}

class SearchedWeatherDetails extends WeatherEvent{
  final String location;
  WeatherModel? model;
  SearchedWeatherDetails({required this.location, this.model});
}

class UpdateSearchedWeather extends WeatherEvent{
  WeatherModel? model;
  UpdateSearchedWeather({this.model});
}