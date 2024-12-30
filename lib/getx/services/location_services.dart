import 'dart:io';
import 'package:fl_location/fl_location.dart' as fl;
import 'package:flutter/foundation.dart';
import 'package:free_map/services/fm_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LocationServices extends GetxService {
  var isEnable = false.obs;
  var country = ''.obs;

  Future<void> getLocation() async {
    try {
      if (await _requestLocationPermission()) {
        final fl.Location location = await fl.FlLocation.getLocation();
        await getCountry(location.latitude, location.longitude);
        print('Location: ${location.toJson()}');
      } else {
        print('Location permission denied or services disabled.');
      }
    } catch (e) {
      print('Error getting location: $e');
      country.value = 'US'; // Fallback to a default country.
    }
  }

  Future<void> getCountry(double lat, double lng) async {
    try {
      final data = await FMService().getAddress(lat: lat, lng: lng);
      if (data?.rawAddress?.countryCode != null) {
        country.value = data!.rawAddress!.countryCode;
        print('Country: ${country.value}');
      } else {
        country.value = 'US'; // Fallback to a default country.
        print('Could not determine country. Using fallback.');
      }
    } catch (e) {
      print('Error fetching country: $e');
      country.value = 'US'; // Fallback to a default country.
    }
  }

  Future<bool> _requestLocationPermission({bool background = false}) async {
    try {
      if (!await fl.FlLocation.isLocationServicesEnabled) {
        print('Location services are disabled.');
        return false;
      }

      fl.LocationPermission permission =
          await fl.FlLocation.checkLocationPermission();

      if (permission == fl.LocationPermission.denied) {
        permission = await fl.FlLocation.requestLocationPermission();
      }

      if (permission == fl.LocationPermission.deniedForever) {
        print('Location permission denied forever.');
        return false;
      }

      return true;
    } catch (e) {
      print('Error requesting location permission: $e');
      return false;
    }
  }
}
