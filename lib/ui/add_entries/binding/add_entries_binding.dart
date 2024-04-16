
import 'package:get/get.dart';
import 'package:money_tracker/ui/add_entries/view/add_entries_controller.dart';

class AddEntriesBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AddEntriesController());
  }

}