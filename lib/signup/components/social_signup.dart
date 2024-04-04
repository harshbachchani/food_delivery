import 'package:flutter/material.dart';
import 'package:food_delivery/signup/components/or_divider.dart';
import 'package:food_delivery/signup/components/social_icon.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIcon(
              iconsrc: "assets/images/google.png",
              press: () {},
            ),
            SocialIcon(
              iconsrc: "assets/images/facebook.png",
              press: () {},
            ),
            SocialIcon(
              iconsrc: "assets/images/twitter.png",
              press: () {},
            )
          ],
        )
      ],
    );
  }
}
