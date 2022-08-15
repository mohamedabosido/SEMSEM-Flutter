import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    brightness: Brightness.light,
    backgroundColor: kOffWhiteColor,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Mulish',
          bodyColor: Colors.black,
        ),
    colorScheme: const ColorScheme.light(secondary: Colors.transparent),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    backgroundColor: kBackgroundDarkColor,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldDarkColor,
    appBarTheme: const AppBarTheme(
        color: kScaffoldDarkColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Mulish',
          bodyColor: Colors.white,
        ),
    colorScheme:
        const ColorScheme.dark().copyWith(secondary: Colors.transparent),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kScaffoldDarkColor,
      showUnselectedLabels: true,
    ),
  );
}
