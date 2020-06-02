import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';


class LocationHelper {


  Future<String> getLocation() async {

//    final GeolocationResult result = await Geolocation.isLocationOperational();
//    if(result.isSuccessful) {
//      // location service is enabled, and location permission is granted
//      print('aa');
//    } else {
//      // location service is not enabled, restricted, or location permission is denied
//      print('bb');
//    }

    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.low);

    if( position != null ) {
      final coordinates = new Coordinates(position.latitude, position.longitude);
//      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);


      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: 'en');

      return placemark.first.country;

//      return addresses.first.countryName;
    } else {
      return '';
    }




  }
}