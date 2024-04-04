import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String topImage, bottomImage;
  const Background(
      {Key? key,
      required this.child,
      this.topImage = "assets/images/main_top.jpg",
      this.bottomImage = "assets/images/main_bottom.jpg"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Image.asset(topImage, width: 120, height: 120),
              // ),
              Positioned(child: child),
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: Image.asset(bottomImage, width: 120, height: 120),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
