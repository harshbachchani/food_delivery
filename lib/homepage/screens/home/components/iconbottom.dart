import 'package:flutter/material.dart';
import 'package:food_delivery/constanst.dart';

class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isselected;
  final Function() onTap;
  const IconBottomBar({
    super.key,
    required this.text,
    required this.icon,
    required this.isselected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: isselected ? kprimaryColor : Colors.grey,
          ),
        ),
        Text(
          text,
          style: TextStyle(
              color: isselected ? kprimaryColor : Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
