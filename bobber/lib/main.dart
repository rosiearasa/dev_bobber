// import 'package:bobber/models/plunge.dart';
// import 'package:bobber/screens/connect.dart';
// import 'package:bobber/screens/home_screen.dart';
// import 'package:bobber/screens/tabs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:bobber/screens/tabs.dart';
import 'package:bobber/theme/theme_constants.dart';
import 'package:bobber/theme/theme_manager.dart';

import 'package:flutter/material.dart';


ThemeManager _themeManager = ThemeManager();
void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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
      home: const TabsScreen(),
    // home: const PlungeItem(),
    );
  }
}
