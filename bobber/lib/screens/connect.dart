
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("connect"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/cee_icon.png'),
            height: 500,
            width: 500,
          ),
     
          Center(
            child: ElevatedButton(
              onPressed: (() {
                print("GO TO STATEFUL WIDGET");
              }),
              child: const Text("Connect"),
            ),
          ),
        ],
      ),
    );
  }
}