import 'package:bobber/widgets/plunge_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String title = 'Home';
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(),
      body: const PlungeItem(),
    );
    //cards in a column widget
  }
}
