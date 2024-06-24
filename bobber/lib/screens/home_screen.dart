import 'package:bobber/controllers/plunge_controller.dart';
import 'package:bobber/widgets/plunge_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {


   HomeScreen({super.key});
 
  PlungeController plungeController = Get.put(PlungeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        // body: const PlungeItem(),
        body: PlungeList());
    //cards in a column widget
  }
}
