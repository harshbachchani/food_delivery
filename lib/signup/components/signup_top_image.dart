import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';

class SignUpTopImage extends StatelessWidget {
  const SignUpTopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "SIGNUP",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .merge(AppFont.headText()),
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 250,
              width: 300,
              child: Image.asset("assets/images/signup.jpg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: kdefaultPadding)
      ],
    );
  }
}
