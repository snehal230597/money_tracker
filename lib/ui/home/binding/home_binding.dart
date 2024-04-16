import 'package:get/get.dart';
import 'package:money_tracker/ui/add_entries/view/add_entries_controller.dart';
import 'package:money_tracker/ui/home/view/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AddEntriesController());
  }
}