import 'package:e_store/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: defaultTealMaterial),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      color: const Color(0xFFF5F5F5),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white.withOpacity(0),
      ),
      surfaceTintColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: defaultTeal,
      elevation: 10.0,
    ),
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultTeal,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.black,
      ),
    ),
    fontFamily: 'Jannah');

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: defaultTealMaterial),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    color: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black.withOpacity(0),
    ),
    surfaceTintColor: Colors.black,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black,
    selectedItemColor: defaultTeal,
    elevation: 10.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultTeal,
    foregroundColor: Colors.black,
  ),
  unselectedWidgetColor: Colors.grey,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      color: Colors.white,
    ),
  ),
);
