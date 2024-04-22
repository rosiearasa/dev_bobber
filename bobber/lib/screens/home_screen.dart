import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String title = 'Home';
  @override
  Widget build(BuildContext context) {
    //shows a list of the data collected from the user
    Widget content = const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('uh non ... nothing ici'),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
   
      ),
      body: content,
    );
    //cards in a column widget
  }
}
