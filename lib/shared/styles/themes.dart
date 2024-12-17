import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold)),
  textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )),
  fontFamily: 'Cairo'
);
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

ThemeData lightTheme = ThemeData(
    primarySwatch: buildMaterialColor(Color(0xFF264D59)),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        toolbarHeight: 70,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Color(0xFF264D59),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold)),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        )),
    fontFamily: 'Cairo'
);