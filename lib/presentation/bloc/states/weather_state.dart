import '../../../domain/weather/weather_model.dart';

abstract class WeatherState{}

class InitialState extends WeatherState{}
class LoaderState extends WeatherState{}

class WeatherLoaded extends WeatherState{
  WeatherModel model;
  WeatherLoaded({required this.model});
}


class WeatherErrorState extends WeatherState{
  final String msg;
  WeatherErrorState({required this.msg});
}

class UpdateLocationDetailsState extends WeatherState{
  List<String> location;
  WeatherModel? model;
  UpdateLocationDetailsState({required this.location, this.model});
}

class SearchCompletedState extends WeatherState{
  WeatherModel model;
  SearchCompletedState({required this.model});
}

class LocationSearchErrorState extends WeatherState{
  final String msg;
  LocationSearchErrorState({required this.msg});
}