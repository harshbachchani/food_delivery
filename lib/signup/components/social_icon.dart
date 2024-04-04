import 'package:flutter/material.dart';
import 'package:food_delivery/constanst.dart';

class SocialIcon extends StatelessWidget {
  final String? iconsrc;
  final Function? press;

  const SocialIcon({super.key, this.iconsrc, this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kprimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          iconsrc!,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
