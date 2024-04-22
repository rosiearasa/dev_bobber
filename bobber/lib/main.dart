import 'package:bobber/screens/connect.dart';
import 'package:bobber/screens/home_screen.dart';
import 'package:bobber/screens/tabs.dart';
import 'package:bobber/theme/theme_constants.dart';
import 'package:bobber/theme/theme_manager.dart';
import 'package:flutter/material.dart';

ThemeManager _themeManager = ThemeManager();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
     return  MaterialApp(
    
      title: "Bobber App",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      // home: const SplashScreen(),
    home: const TabsScreen(),
    );
  }
}
