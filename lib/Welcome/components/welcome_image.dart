import 'package:flutter/material.dart';

import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome to Zapto",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .merge(AppFont.headText()),
        ),
        const SizedBox(height: kdefaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset("assets/images/welcome_image.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: kdefaultPadding * 2)
      ],
    );
  }
}
