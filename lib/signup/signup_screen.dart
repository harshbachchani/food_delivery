import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/components/background.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/responsive.dart';
import 'package:food_delivery/signup/components/signup_form.dart';
import 'package:food_delivery/signup/components/signup_top_image.dart';
import 'package:food_delivery/signup/components/social_signup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignUpScreen(),
          desktop: Row(
            children: [
              Expanded(child: SignUpTopImage()),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 450,
                    child: SignUpForm(),
                  ),
                  SizedBox(height: kdefaultPadding / 2),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignUpScreen extends StatelessWidget {
  const MobileSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SignUpTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(flex: 8, child: SignUpForm()),
            Spacer(),
          ],
        ),
        SocialSignUp()
      ],
    );
  }
}
