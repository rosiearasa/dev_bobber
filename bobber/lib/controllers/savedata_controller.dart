import 'package:bobber/models/plunge.dart';
import 'package:bobber/repository/plunge_repository.dart';
import 'package:get/get.dart';

class SaveDataController extends GetxController {
  static SaveDataController get instance => Get.find();
  final plungeRepo = Get.put(PlungeRepository());

  Future<void> createPlunge(Plunge plunge) async {
    print("we got here");
    await plungeRepo.createPlunge(plunge);
  }
}
