// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Welcome/welcome_screen.dart';
import 'package:food_delivery/components/session.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/home/homepage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocationController controller = Get.find();

  @override
  void initState() {
    super.initState();

    SessionManager.isLoggedIn().then((val) async {
      if (val['loggedin']) {
        UserDetails userDetails = Get.find();
        userDetails.updateuid(val['uid']);
        DatabaseReference refer =
            FirebaseDatabase.instance.ref('Users').child(val['uid'].toString());
        await refer.get().then((value) {
          Map<dynamic, dynamic> x = value.value as Map<dynamic, dynamic>;
          userDetails.updatename(x['name']);
          userDetails.updatenumber(x['phone_number']);
          userDetails.updatemail(x['email']);
        }).onError((error, stackTrace) {
          debugPrint("Hello");
          debugPrint(error.toString());
        });
        SessionManager.getLocation().then((x) {
          controller.updatelocation(x['latitude'], x['longitude']);
          controller.updateonlyaddress(x['address'], x['city']);
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      } else {
        checkLocationPermission().then((value) {
          controller.updatelocation(value.latitude, value.longitude);
          getCity(value.latitude, value.longitude);
          SessionManager.saveLocation(value.latitude, value.longitude,
              controller.getaddress(), controller.getcity());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ));
        }).onError((error, stackTrace) {
          getsnackbar("Error", "Unable to fetch location");
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getCity(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address =
          "${placemark.thoroughfare} ${placemark.subLocality} ${placemark.locality},${placemark.postalCode}, ${placemark.country}";
      String cityName = placemark.locality!;
      controller.updateonlyaddress(address, cityName);
    }
    return "Udaipur";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Lottie.asset('assets/animation/splash.json'),
        ),
      ),
    );
  }

  Future<Position> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
            "Location Permission Are Denied", "Turn On to proceed further");
        Navigator.pop(context);
        return Future.error("Location Permimssion are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          "Location Permission Are Denied Forever", "Turn On from settings");
      Navigator.pop(context);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
