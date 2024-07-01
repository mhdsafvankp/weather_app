import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('WeatherScreen')));
  }
}
