
import 'package:bobber/widgets/plunge_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String title = 'Home';
  @override
  Widget build(BuildContext context) {
 
    return const Scaffold(
      // appBar: AppBar(),
      // body: const PlungeItem(),
      body:  PlungeList()
    );
    //cards in a column widget
  }
}
