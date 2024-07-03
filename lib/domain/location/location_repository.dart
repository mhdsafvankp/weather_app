
import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {

   /// fetch the current position if location permission are given
   Future<Position> determinePosition();
}