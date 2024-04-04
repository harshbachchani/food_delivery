import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/Welcome/splash_screen.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/components/session.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/order/orders.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    UserDetails userdetail = Get.put(UserDetails());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 83, 69, 164),
                const Color.fromARGB(255, 66, 53, 165).withOpacity(.8),
                const Color.fromARGB(255, 75, 53, 165).withOpacity(.6),
                const Color.fromARGB(255, 121, 112, 159).withOpacity(.4),
                const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
                const Color(0xFF6F35A5).withOpacity(.1),
                const Color(0xFF6F35A5).withOpacity(.05),
                const Color(0xFF6F35A5).withOpacity(.25)
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {},
              tooltip: "Menu",
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
            centerTitle: true,
            title: Text(
              "Profile",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .merge(AppFont.headText(color: Colors.white)),
            ),
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.moon, color: Colors.white),
                onPressed: () {},
              ),
            ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset('assets/images/main_bottom.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => Text(
                      userdetail.getname(),
                      style:
                          AppFont.regularText(25, color: Colors.grey.shade800),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => Text(
                      userdetail.getemail(),
                      style:
                          AppFont.regularText(15, color: Colors.grey.shade800),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Text(
                        'Edit Profile',
                        style: AppFont.headText(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Divider(color: Colors.grey.shade400, thickness: 1),
                  const SizedBox(height: 25),
                  ProfileMenuWidget(
                      text: "Settings",
                      icon: FontAwesomeIcons.gear,
                      press: () {}),
                  ProfileMenuWidget(
                      text: "Orders",
                      icon: FontAwesomeIcons.noteSticky,
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderPage(),
                            ));
                      }),
                  ProfileMenuWidget(
                      text: "User Mangement",
                      icon: FontAwesomeIcons.userCheck,
                      press: () {}),
                  Divider(color: Colors.grey.shade400, thickness: 0.5),
                  const SizedBox(height: 15),
                  ProfileMenuWidget(
                      text: "Help & Support",
                      icon: FontAwesomeIcons.circleQuestion,
                      press: () {}),
                  ProfileMenuWidget(
                      text: "Privacy Policy",
                      icon: FontAwesomeIcons.lock,
                      press: () {}),
                  ProfileMenuWidget(
                    text: "LogOut",
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    press: () {
                      _auth.signOut();
                      SessionManager.logout().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplashScreen(),
                            ),
                            (route) => false);
                      });
                    },
                    color: Colors.red.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.text,
      required this.icon,
      required this.press,
      this.endIcon = true,
      this.color});
  final String text;
  final IconData icon;
  final VoidCallback press;
  final bool endIcon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: color ?? Theme.of(context).primaryColorDark,
          size: 22,
        ),
      ),
      title: Text(
        text,
        style: AppFont.regularText(20, color: color),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                FontAwesomeIcons.angleRight,
                color: Colors.grey,
                size: 15,
              ),
            )
          : null,
    );
  }
}
