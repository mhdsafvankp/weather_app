import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/bloc/splash_bloc.dart';
import 'package:weather_app/application/bloc/weather_bloc.dart';
import 'package:weather_app/domain/common/logger.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/events/splash_event.dart';
import 'package:weather_app/presentation/bloc/events/weather_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';
import 'package:weather_app/presentation/bloc/states/splash_state.dart';
import 'package:weather_app/presentation/bloc/states/weather_state.dart';
import 'package:weather_app/routes/app_router.dart';

import '../../domain/common/constants.dart';
import '../../infrastructure/core/debounce.dart';

@RoutePage()
class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  final _controller = TextEditingController();
  List<String> _locations = [];
  final _debounce = Debounce(const Duration(milliseconds: 1000));


  @override
  void initState() {
    super.initState();
    context
        .read<WeatherBloc>()
        .add(LoadPreDefinedLocations());
  }

  @override
  Widget build(BuildContext context) {
    print('build : build');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  onChanged: (searchValue) {
                    _debounce((){
                      context
                          .read<WeatherBloc>()
                          .add(WeatherSearchEvent(query: searchValue));
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter location',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              BlocConsumer<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if(state is UpdateLocationDetailsState){
                      _locations = state.location;
                      if(_locations.isEmpty){
                        return const Text(cityNotFound);
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: _locations.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_locations[index]),
                              onTap: () {
                                context.read<WeatherBloc>().add(
                                    SearchedWeatherDetails(
                                        location: _locations[index],
                                        model: state.model));
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text('$loading...'),
                          )
                        ],
                      ),
                    );
                  },
                  listener: (context, state) {
                    if(state is SearchCompletedState){
                      var weatherModel = state.model;
                      AutoRouter.of(context).maybePop(weatherModel);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
