import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kprimaryColor = Color(0xFF6F35A5);
const kprimaryLightColor = Color(0xFFF1E6FF);
const double kdefaultPadding = 16.0;

class RestaurantInfo {
  String imageUrl, title, location, rating, price, description;
  RestaurantInfo(
      {required this.imageUrl,
      required this.title,
      required this.location,
      required this.rating,
      required this.description,
      required this.price});
}

class FoodInfo {
  String imageUrl, title;
  FoodInfo({required this.imageUrl, required this.title});
}

class CityInfo {
  double lat, long;
  String name;
  CityInfo({required this.name, required this.lat, required this.long});
}

List<CityInfo> mycities = [
  CityInfo(name: "Delhi", lat: 28.7041, long: 77.1025),
  CityInfo(name: "Mumbai", lat: 19.0760, long: 77.1025),
  CityInfo(name: "Bangalore", lat: 12.9716, long: 77.5946),
  CityInfo(name: "Kolkata", lat: 22.5726, long: 88.3639),
  CityInfo(name: "Chennai", lat: 13.0827, long: 80.2707),
  CityInfo(name: "Hyderabad", lat: 17.3850, long: 78.4867),
  CityInfo(name: "Pune", lat: 18.5204, long: 73.8567),
  CityInfo(name: "Ahmedabad", lat: 23.0225, long: 72.5714),
  CityInfo(name: "Jaipur", lat: 26.9124, long: 75.7873),
  CityInfo(name: "Surat", lat: 21.1702, long: 72.8311),
  CityInfo(name: "Lucknow", lat: 26.8467, long: 80.9462),
  CityInfo(name: "Kanpur", lat: 26.4499, long: 80.3319),
  CityInfo(name: "Nagpur", lat: 21.1458, long: 79.0882),
  CityInfo(name: "Patna", lat: 25.5941, long: 85.1376),
  CityInfo(name: "Indore", lat: 22.7196, long: 75.8577),
  CityInfo(name: "Udaipur", lat: 24.585445, long: 73.712479),
];
SnackbarController getsnackbar(String msg, String title) {
  return Get.snackbar(msg, title,
      colorText: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.3),
      duration: const Duration(milliseconds: 1300));
}
