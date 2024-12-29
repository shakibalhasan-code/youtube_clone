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
    if (await _requestLocationPermission()) {
      final fl.Location location = await fl.FlLocation.getLocation();
      await getCountry(location.latitude, location.longitude);
      print('Location: ${location.toJson()}');
    }
  }

  Future<void> getCountry(double lat, double lng) async {
    final data = await FMService().getAddress(
      lat: lat,
      lng: lng,
    );
    country.value = data!.rawAddress!.countryCode;
    print('Country: ${country.value}');
  }

  Future<bool> _requestLocationPermission({bool background = false}) async {
    if (!await fl.FlLocation.isLocationServicesEnabled) {
      // Location services is disabled.
      return false;
    }

    fl.LocationPermission permission =
        await fl.FlLocation.checkLocationPermission();
    if (permission == fl.LocationPermission.denied) {
      // Android: ACCESS_COARSE_LOCATION or ACCESS_FINE_LOCATION
      // iOS 12-: NSLocationWhenInUseUsageDescription or NSLocationAlwaysAndWhenInUseUsageDescription
      // iOS 13+: NSLocationWhenInUseUsageDescription
      permission = await fl.FlLocation.requestLocationPermission();
    }

    if (permission == fl.LocationPermission.denied ||
        permission == fl.LocationPermission.deniedForever) {
      // Location permission has been ${permission.name}.
      return false;
    }

    return true;
  }
}
