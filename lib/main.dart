import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Welcome/splash_screen.dart';

import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/bottom_navigation_controller.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';

import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(BottomNavigationController());
  Get.put(LocationController());
  Get.put(UserDetails());
  runApp(const MyApp());
}

// ...

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zapto',
      theme: ThemeData(
        primaryColor: kprimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kprimaryColor,
          shape: const StadiumBorder(),
          minimumSize: const Size(double.infinity, 56),
          maximumSize: const Size(double.infinity, 56),
        )),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kprimaryLightColor,
            prefixIconColor: kprimaryColor,
            contentPadding: EdgeInsets.all(kdefaultPadding),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            )),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
