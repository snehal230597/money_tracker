
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/app/app_routes.dart';
import 'package:money_tracker/data/database/localdata.dart';
import 'package:money_tracker/data/model/add_entry_model.dart';
import 'package:money_tracker/utility/utils.dart';
import 'package:sqflite/sqflite.dart';

class AddEntriesController extends GetxController{

  var selectedValue = 'earnings'.obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  RxString selectedDate = "Select Date".obs;
  Rx<DateTime> initialDate = DateTime.now().obs;

  var entries = <AddEntryModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void clearTextFields() {
    amountController.clear();
    descriptionController.clear();
    selectedDate.value = "Select Date";
  }

  void addEntry(AddEntryModel entry) {
    entries.add(entry);
  }
  void deleteEntry(int index) {
    entries.removeAt(index);
  }

  void selectValue(String? value) {
    selectedValue.value = value!;
  }

  //select date
  void openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: initialDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,"0")}-${pickedDate.day.toString().padLeft(2,"0")}";
      initialDate.value = pickedDate;
    }
  }

  /// Add entries
  void addEntries() async {
    if(checkValidations()){
      // // Show date picker and add entry
      // addEntry(AddEntryModel(
      //   type: selectedValue.value.toString(), // or 'expense'
      //   amount: double.parse(amountController.text), // Get value from text field
      //   description: descriptionController.text, // Get value from text field
      //   date: selectedDate.value.toString(), // Get value from date picker
      // ));
      Database? db = await DatabaseHelper.instance.database;
      Map<String, dynamic> row = {
        DatabaseHelper.columnType : selectedValue.value.toString(),
        DatabaseHelper.columnPrice  : amountController.text,
        DatabaseHelper.columnDes : descriptionController.text.trim(),
        DatabaseHelper.columndate : selectedDate.value.toString(),
      };
      int? id = await db?.insert(DatabaseHelper.table, row);
      print(await db?.query(DatabaseHelper.table));
      clearTextFields();
      Get.back(result: true);
    }
  }

  /// Check email & password validations as needed
  bool checkValidations() {
    if (amountController.text.trim().isEmpty) {
      Utils.showMessage('Please Enter Amount.');
      return false;
    } else if (descriptionController.text.trim().isEmpty) {
      Utils.showMessage('Please Enter Description');
      return false;
    } else if (selectedDate.value == "Select Date" ) {
      Utils.showMessage("Please Select Date");
      return false;
    }
    return true;
  }
 /// DataBase Helper to Insert Data in Local Database
  insert() async {

    addEntries();


  }

}