import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.black,
    color: Color.lerp(Colors.yellowAccent, Colors.white, 0.8),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color.lerp(
          Color.lerp(Colors.yellowAccent, Colors.white, 0.8),
          Colors.black,
          0.4),
    ),
  ),
  // brightness: Brightness.light,
  colorScheme: const ColorScheme.light(),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color.lerp(Colors.black, Colors.white, 0.1),
        statusBarIconBrightness: Brightness.light),
    foregroundColor: Colors.white,
    color: Color.lerp(Colors.black, Colors.white, 0.15),
  ),
  // brightness: Brightness.dark,
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(),
);
