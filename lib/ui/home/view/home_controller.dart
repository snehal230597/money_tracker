import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_tracker/app/app_routes.dart';
import 'package:money_tracker/data/database/localdata.dart';
import 'package:money_tracker/data/local/session_manager.dart';
import 'package:money_tracker/data/model/add_entry_model.dart';
import 'package:money_tracker/ui/add_entries/view/add_entries_controller.dart';

class HomeController extends GetxController{

  final AddEntriesController entryController = Get.find();

  var scaffoldKey = GlobalKey<ScaffoldState>();
 // Map<String, dynamic> data = Get.arguments;

  RxDouble totalEarnings = 0.0.obs;
  RxDouble totalExpenses = 0.0.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();

  }

  void fetchData()async{
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    List fetchData  = await dbHelper.fetchProductData();
    debugPrint("====FetchProduct${fetchData}");
    for(var data in fetchData){
      entryController.entries.add(AddEntryModel(type: data["type"], amount: double.parse("${data["amount"]}.0"), description: data["description"], date: data["date"], key: data["_id"]));
    }

    updateAmounts();
  }



  /// Open side drawer
  void openSideDrawer(bool value) {
    if (value) {
      scaffoldKey.currentState?.openDrawer();
    } else {
      scaffoldKey.currentState?.openEndDrawer();
    }
  }

  /// Logout current user form app
  Future<void> googleLogout() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    dbHelper.deleteAll();
    StorageManager().clearSession();
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.initialRoute);
  }


void updateAmounts(){

  totalExpenses.value =
      entryController.entries.where((entry) => entry.type == 'expenses').fold(
          0, (previousValue, entry) => previousValue + entry.amount);


  totalEarnings.value =       entryController.entries.where((entry) => entry.type == 'earnings').fold(
      0, (previousValue, entry) => previousValue + entry.amount);
}

}