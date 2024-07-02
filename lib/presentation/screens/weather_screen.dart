import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/bloc/auth_bloc.dart';
import 'package:weather_app/application/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/events/weather_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';
import 'package:weather_app/presentation/bloc/states/weather_state.dart';
import 'package:weather_app/presentation/widgets/custom_text_button.dart';
import '../../domain/common/constants.dart';
import '../../routes/app_router.dart';
import '../bloc/events/auth_event.dart';
import '../widgets/submit_button.dart';

@RoutePage()
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(LoadWeatherScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is UnAuthenticated) {
                  AutoRouter.of(context)
                      .replace(AuthLoginRoute());
                }
              },
              child: BlocConsumer<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoaded) {
                      var weatherModel = state.model;
                      var location = weatherModel.name;
                      var country = weatherModel.sys.country;
                      var speed = weatherModel.wind.speed;
                      var min = weatherModel.main.tempMin;
                      var max = weatherModel.main.tempMax;
                      var temp = weatherModel.main.temp;
                      var humidity = weatherModel.main.humidity;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hey,',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _rowValues(context, location, country),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16, left: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _columValues(context, 'MIN',
                                          '${min.toString()}°C'),
                                      _columValues(context, 'CURRENT',
                                          '${temp.toString()}°C'),
                                      _columValues(
                                          context, 'MAX', '${max.toString()}°C')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _rowValues(context, 'HUMIDITY',
                                      '${humidity.toString()}%'),
                                  _rowValues(context, 'WIND SPEED',
                                      '${speed.toString()}m/s'),
                                ]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SubmitButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Search for Location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.search,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CustomTextButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(SingOutRequested());
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Log out'),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.logout),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is WeatherErrorState) {
                      return Text(state.msg);
                    } else {
                      return const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text('$checkingTheWeather...'),
                          )
                        ],
                      );
                    }
                  },
                  listener: (context, state) {}))),
    );
  }

  Widget _columValues(BuildContext context, String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _rowValues(BuildContext context, String title, String value) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
