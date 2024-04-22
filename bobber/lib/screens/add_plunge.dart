//a screen to manually add the plunge data. 

import 'package:flutter/material.dart';

class AddPlunge extends StatelessWidget {
  const AddPlunge({super.key});
  final String title = 'Add Data Manually';
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
      appBar: AppBar(),
      body:content,
    );
    //cards in a column widget
  }
}