import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Welcome/components/login_signup_btn.dart';
import 'package:food_delivery/Welcome/components/welcome_image.dart';
import 'package:food_delivery/components/background.dart';
import 'package:food_delivery/responsive.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static DatabaseReference databaseuser =
      FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: WelcomeImage()),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginAndSignUpBtn(),
                    )
                  ],
                ))
              ],
            ),
            mobile: MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignUpBtn(),
            ),
            Spacer(),
          ],
        )
      ],
    );
  }
}
