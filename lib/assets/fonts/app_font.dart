import 'package:flutter/material.dart';
import 'package:food_delivery/constanst.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont {
  static TextStyle headText({Color? color}) {
    return GoogleFonts.notoSans(
      fontWeight: FontWeight.w800,
      color: color ?? Colors.black,
    );
  }

  static TextStyle mediumText(double a, {Color? color}) {
    return GoogleFonts.notoSans(
      fontSize: a,
      fontWeight: FontWeight.w600,
      color: color ?? Colors.black,
    );
  }

  static TextStyle krpimaryText(double a, {Color? color}) {
    return GoogleFonts.notoSans(
      fontSize: a,
      fontWeight: FontWeight.w400,
      color: color ?? kprimaryColor,
    );
  }

  static TextStyle regularText(double a, {Color? color}) {
    return GoogleFonts.notoSans(
      fontSize: a,
      fontWeight: FontWeight.normal,
      color: color ?? Colors.black,
    );
  }
}
