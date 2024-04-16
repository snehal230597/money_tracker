import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_tracker/app/app_colors.dart';
import 'package:money_tracker/app/app_font_weight.dart';
import 'package:money_tracker/data/database/localdata.dart';
import 'package:money_tracker/ui/all_transaction/view/all_transaction_controller.dart';
import 'package:money_tracker/widgets/common_text.dart';

class AllTransactionPage extends GetView<AllTransactionController> {
  const AllTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.colorBlack,
          title: CommonMontserratText(
            text: "All Transactions", textSize: 16.sp, fontWeight: AppFontWeight.bold, color: AppColors.colorWhite,),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
        ),
        body: controller.entryController.entries.isEmpty ? SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
               SizedBox(height: Get.height / 2.3),
              CommonMontserratText(text: 'No Transaction', textSize: 20.sp),
            ],
          ),
        ) : SizedBox(
          // height: 500.h,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount:  controller.entryController.entries.length,
            itemBuilder: (context, index) {
              final item = controller.entryController.entries[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
                      decoration: BoxDecoration(
                        color: item.type == 'expenses' ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonMontserratText(text: 'Type: ${item.type}', textSize: 12.sp, color: AppColors.colorWhite,),
                              CommonMontserratText(text: 'Amount: ${item.amount}', textSize: 12.sp, color: AppColors.colorWhite,),
                              CommonMontserratText(text: 'Description: ${item.description}', textSize: 12.sp, color: AppColors.colorWhite,),
                              CommonMontserratText(text: 'Date: ${item.date}', textSize: 12.sp, color: AppColors.colorWhite,),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  // Handle edit action
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white),
                                onPressed: () {
                                  // Handle delete action
                                  DatabaseHelper dbHelper = DatabaseHelper.instance;
                                  dbHelper.deleteData(item.key);
                                  controller.entryController.deleteEntry(index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }

}