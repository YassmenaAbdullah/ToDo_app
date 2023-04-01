import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF66BB6A);
  static const Color green = Color(0xff06730c);
  static const Color colorGray = Color(0xFFC8C9CB);
  static const Color lightScaffoldBackgroundColor = Color(0xffe7f8ea);
  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      colorScheme: ColorScheme.light(
        primary: lightPrimary,
        onPrimary: Colors.white,
        onSurface: green,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: lightPrimary, // button text color
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      scaffoldBackgroundColor: lightScaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimary,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        )),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(
          size: 36,
          color: lightPrimary,
        ),
        unselectedIconTheme: IconThemeData(
          size: 30,
          color: colorGray,
        ),
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline6: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline4: TextStyle(
          fontSize: 14.6,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightPrimary,
      ));
}
