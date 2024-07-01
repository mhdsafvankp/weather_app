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