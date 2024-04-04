import 'package:flutter/material.dart';
import 'package:food_delivery/homepage/controller/bottom_navigation_controller.dart';
import 'package:food_delivery/homepage/screens/home/components/iconbottom.dart';
import 'package:food_delivery/homepage/screens/home/components/mainhome.dart';
import 'package:food_delivery/homepage/screens/profile/profile.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavigationController bottomNavController = Get.find();
  List<Widget> pages = [
    const MainHomePage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages.elementAt(bottomNavController.iconnum.value)),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 90,
        elevation: 3,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconBottomBar(
                      text: "Home",
                      icon: Icons.home,
                      isselected: bottomNavController.iconnum.value == 0,
                      onTap: () {
                        bottomNavController.changeicon(0);
                      }),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  IconBottomBar(
                      text: "Profile",
                      icon: Icons.person,
                      isselected: bottomNavController.iconnum.value == 1,
                      onTap: () {
                        bottomNavController.changeicon(1);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
