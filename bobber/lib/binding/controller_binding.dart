import 'package:bobber/controllers/plunge_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PlungeController>(PlungeController());
    
  }
}
