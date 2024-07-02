import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/application/blocs/auth_bloc/auth_bloc.dart';
import 'package:weather_app/application/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_app/infrastructure/auth/firebase_auth_repository_impl.dart';

import 'application/blocs/splash_bloc/splash_bloc.dart';
import 'domain/weather/entities/weather_model.dart';
import 'infrastructure/core/dio_api_client.dart';
import 'infrastructure/core/hive_service.dart';
import 'infrastructure/location/location_repository_impl.dart';
import 'infrastructure/weather/weather_local_data_source.dart';
import 'infrastructure/weather/weather_remote_data_source.dart';
import 'infrastructure/weather/weather_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // initialize the Hive locations and adapters
  await Hive.initFlutter();
  // registering the adapters 
  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(MainAdapter());
  Hive.registerAdapter(SysAdapter());
  Hive.registerAdapter(WindAdapter());

  // Register Hive Services and initialize them
  final weatherHiveService = HiveService<WeatherModel>('weatherBox');
  await weatherHiveService.init();
  locator.registerSingleton<HiveService<WeatherModel>>(weatherHiveService);

  final authHiveService = HiveService<bool>('authBox');
  await authHiveService.init();
  locator.registerSingleton<HiveService<bool>>(authHiveService);


  //Bloc
  locator
      .registerFactory(() => AuthBloc(firebaseAuthRepositoryImpl: locator()));
  locator.registerFactory(() => SplashBloc());
  locator.registerFactory(() => WeatherBloc(
      weatherRepositoryImpl: locator(), locationRepositoryImpl: locator()));

  // Repositories
  // firebase
  locator.registerLazySingleton<FirebaseAuthRepositoryImpl>(
      () => FirebaseAuthRepositoryImpl(firebaseAuth: locator(), hiveService: authHiveService));
  // WeatherRepository
  locator.registerLazySingleton<WeatherRepositoryImpl>(
      () => WeatherRepositoryImpl(localDataSource: locator(), remoteDataSource: locator()));
  // LocationRepository
  locator.registerLazySingleton<LocationRepositoryImpl>(
      () => LocationRepositoryImpl());
  // localDataSource
  locator.registerLazySingleton<WeatherLocalDataSource>(
          () => WeatherLocalDataSource(hiveService: weatherHiveService));
  // remoteDataSource
  locator.registerLazySingleton<WeatherRemoteDataSource>(
          () => WeatherRemoteDataSource(client: locator()));
  // DioApiClient
  locator.registerLazySingleton<DioApiClient>(
          () => DioApiClient(dio: locator()));

  // external
  // firebaseAuth instance
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => Dio());
}
