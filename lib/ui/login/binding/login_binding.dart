import 'package:get/get.dart';
import 'package:money_tracker/ui/login/view/login_controller.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginInController());
  }
}
