import 'package:bobber/models/plunge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlungeRepository extends GetxController {
  static PlungeRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createPlunge(Plunge plunge) async {
    try {
      await _db.collection('Plunges').add(plunge.toJson()).whenComplete(
            () => Get.snackbar("Success", "Your Plunge Has Been Added",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green),
          );
    } catch (error) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);

      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        library: 'Firebase Save Data',
        context: ErrorSummary('while  running aasyc test code'),
      ));
    }
  }
}
