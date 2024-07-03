

import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/domain/location/location_repository.dart';

import '../../domain/common/logger.dart';


/// Used to get the current location
class LocationRepositoryImpl implements LocationRepository{


  @override
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw AppException(message: 'Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          throw AppException(message: 'Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw AppException( message:
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();

    } on AppException catch (e){
      logPrint('LocationLog: determinePosition ${e.message}');
      throw AppException(message: e.message);
    } catch (e){
      throw AppException();
    }


  }

}