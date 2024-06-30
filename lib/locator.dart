import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/application/bloc/auth_bloc.dart';
import 'package:weather_app/infrastructure/auth/firebase_auth_repository_impl.dart';

import 'common/constants.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // initialize the Hive locations
  await Hive.initFlutter();
  // created the hive box
  locator.registerSingleton<Box>(await Hive.openBox(weather));

  //Bloc
  locator
      .registerFactory(() => AuthBloc(firebaseAuthRepositoryImpl: locator()));

  // Repository
  locator.registerLazySingleton<FirebaseAuthRepositoryImpl>(
      () => FirebaseAuthRepositoryImpl(firebaseAuth: locator()));

  // external
  locator.registerLazySingleton(()=> FirebaseAuth.instance);
}
