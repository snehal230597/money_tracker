
import 'package:get/get.dart';
import 'package:money_tracker/ui/all_transaction/view/all_transaction_controller.dart';

class AllTransactionBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AllTransactionController());
  }

}