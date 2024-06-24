
import 'package:bobber/binding/controller_binding.dart';
import 'package:bobber/controllers/plunge_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';

import 'package:bobber/screens/tabs.dart';
import 'package:bobber/theme/theme_constants.dart';
import 'package:bobber/theme/theme_manager.dart';

import 'package:flutter/material.dart';


ThemeManager _themeManager = ThemeManager();
Future <void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
     RestorationScope(restorationId: 'root', child:   MyApp())
   
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
     return  GetMaterialApp(
    
      title: "Bobber App",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const TabsScreen(),
      initialBinding:ControllerBinding() ,
      debugShowCheckedModeBanner: false,
  
    );
  }
}
