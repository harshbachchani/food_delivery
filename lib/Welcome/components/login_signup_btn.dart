import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';

import 'package:food_delivery/login/login_screen.dart';
import 'package:food_delivery/signup/signup_screen.dart';

class LoginAndSignUpBtn extends StatelessWidget {
  const LoginAndSignUpBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            },
            child: Text("login".toUpperCase(), style: AppFont.headText()),
          ),
        ),
        const SizedBox(height: kdefaultPadding),
        Hero(
          tag: "signup_btn",
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kprimaryLightColor,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ));
            },
            child: Text("Sign Up".toUpperCase(), style: AppFont.headText()),
          ),
        ),
      ],
    );
  }
}
