import 'package:bobber/models/plunge.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';

class PlungeController extends GetxController {
  RxList plungesList = <Plunge>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    isLoading(true);

    try {
      QuerySnapshot plunges = await FirebaseFirestore.instance
          .collection('plungetest')
          .orderBy('id')
          .get();
      plungesList.clear();
      for (var plunge in plunges.docs) {
        plungesList.add(Plunge(
            dateTimeStarted: plunge['dateTimeStarted'].toDate(),
            dateTimeCompleted: plunge['dateTimeCompleted'].toDate(),
            duration: plunge['duration'],
            temperature: plunge['temperature']));
      }

      isLoading(false);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> createPlunge(Plunge plunge) async {
    try {
      await FirebaseFirestore.instance.collection('plungetest').doc().set({
        'dateTimeCompleted': plunge.dateTimeCompleted,
        'dateTimeStarted': plunge.dateTimeStarted,
        'duration': plunge.duration,
        'temperature': plunge.temperature
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deletePlunge(String docRef) async {
   

    FirebaseFirestore.instance
        .collection('plungetest')
        .doc(docRef)
        .delete()
        .then((doc) => Get.snackbar('Success', "Delete Successful"));

    try {} catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
