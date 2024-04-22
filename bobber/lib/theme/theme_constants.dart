import 'package:flutter/material.dart';

const COLOR_LIFESAVING = Color.fromARGB(255, 255, 152, 0);
const COLOR_BLACKPRIMARY = Colors.black;
const COLOR_SPLASHDOWN = Color.fromARGB(255, 13, 122, 211);
const COLOR_LIGHTCOLOR = Colors.white;
const COLOR_RITUALS = Color.fromARGB(255, 242, 239, 229);
const COLOR_MOONLIGHT = Color.fromARGB(255, 211, 212, 202);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
          seedColor: COLOR_LIFESAVING, brightness: Brightness.light)
      .copyWith(background: COLOR_MOONLIGHT),
  // brightness: Brightness.light,
  // primaryColor: COLOR_LIFESAVING,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: COLOR_LIFESAVING),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(COLOR_LIFESAVING),
    ),
  ),
  textTheme: const TextTheme(
    headline2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),

  scaffoldBackgroundColor: COLOR_MOONLIGHT,
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
