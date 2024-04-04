import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "LOGIN",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .merge(AppFont.headText()),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: kdefaultPadding),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset("assets/images/delivery.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: kdefaultPadding)
      ],
    );
  }
}
