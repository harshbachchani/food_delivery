import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/session.dart';
import 'package:food_delivery/homepage/screens/restaurant_details/restaurant_details.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxDouble lat = 28.0.obs;
  RxDouble long = 70.0.obs;
  RxString address = "Udaipur".obs;
  RxString city = "Udaipur".obs;
  updatelocation(double a, double b) {
    lat.value = a;
    long.value = b;
  }

  updateonlyaddress(String a, String b) {
    address.value = a;
    city.value = b;
  }

  updateaddress(String a, String b) async {
    if (userDetails.getuid() == "") {
      address.value = a;
      city.value = b;
    } else {
      DatabaseReference dref =
          FirebaseDatabase.instance.ref('Users').child(userDetails.getuid());
      await dref.update({
        'address': a,
        'city': b,
      }).then((value) {
        address.value = a;
        city.value = b;
        Get.snackbar("Updated", "Address is updated");
      }).onError((error, stackTrace) {
        Get.snackbar("Failed", "Failed to update address try again");
      });
    }
    await getLatLongFromCityName(b);
  }

  Future<void> getLatLongFromCityName(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        lat.value = latitude;
        long.value = longitude;
        SessionManager.saveLocation(
            latitude, longitude, cityName, address.value);
        debugPrint('Latitude: $latitude, Longitude: $longitude');
      } else {
        debugPrint('No location found for the city: $cityName');
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }

  getcity() {
    return city.value;
  }

  getaddress() {
    return address.value;
  }

  getlat() {
    return lat.value;
  }

  getlong() {
    return long.value;
  }
}
