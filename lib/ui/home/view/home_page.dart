import 'package:money_tracker/app/app_class.dart';
import 'package:money_tracker/data/local/session_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_tracker/app/app_colors.dart';
import 'package:money_tracker/app/app_font_weight.dart';
import 'package:money_tracker/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/data/database/localdata.dart';
import 'package:money_tracker/ui/home/view/home_controller.dart';
import 'package:money_tracker/widgets/common_app_button.dart';
import 'package:money_tracker/widgets/common_text.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        key: controller.scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.colorBlack,
          title: CommonMontserratText(
            text: "ICoderz Money Tracker",
            textSize: 16.sp,
            fontWeight: AppFontWeight.bold,
            color: AppColors.colorWhite,
          ),
          leading: InkWell(
            child: const Icon(
              Icons.line_weight_sharp,
              size: 24,
              color: AppColors.colorWhite,
            ),
            onTap: () => controller.openSideDrawer(true),
          ),
        ),
        drawer: getDrawerView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.colorBlack,
          onPressed: () {
            Get.toNamed(AppRoutes.addEntriesPage)!.then((value) {
              if (value == true) {
                controller.entryController.entries.clear();
                controller.fetchData();
                controller.updateAmounts();
              }
            });
          },
          child: const Icon(Icons.add, color: AppColors.colorWhite),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Container(
                  height: 50.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20.w),
                      CommonMontserratText(text: 'Current Balance :', textSize: 16.sp, fontWeight: AppFontWeight.bold),
                      const Spacer(),
                      CommonMontserratText(
                          text: "${controller.totalEarnings.value - controller.totalExpenses.value}",
                          textSize: 16.sp,
                          fontWeight: AppFontWeight.bold),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 50.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20.w),
                      CommonMontserratText(text: 'Net Earnings :', textSize: 16.sp, fontWeight: AppFontWeight.bold),
                      Spacer(),
                      CommonMontserratText(
                          text: controller.totalEarnings.toString(), textSize: 16.sp, fontWeight: AppFontWeight.bold),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 50.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20.w),
                      CommonMontserratText(text: 'Net Expanses :', textSize: 16.sp, fontWeight: AppFontWeight.bold),
                      const Spacer(),
                      CommonMontserratText(
                          text: controller.totalExpenses.toString(), textSize: 16.sp, fontWeight: AppFontWeight.bold),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                const Divider(
                  color: Colors.grey,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    CommonMontserratText(
                      text: 'Last 3 Transactions',
                      textSize: 14.sp,
                      fontWeight: AppFontWeight.medium,
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.allTransactionPage)!.then((value) {
                            controller.updateAmounts();
                          });
                        },
                        child: CommonMontserratText(
                          text: 'View All',
                          textSize: 14.sp,
                          fontWeight: AppFontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(height: 10.h),
                controller.entryController.entries.isEmpty
                    ? Column(
                        children: [
                          SizedBox(height: 100.h),
                          CommonMontserratText(text: 'No Transaction', textSize: 20.sp),
                        ],
                      )
                    : allTransactionList(),
              ],
            ),
          ),
        ),
      );
    });
    // return
  }

  Widget allTransactionList() {
    return Obx(() {
      return SizedBox(
        height: 500.h,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.entryController.entries.length > 3 ? 3 : controller.entryController.entries.length,
          itemBuilder: (context, index) {
            final item = controller.entryController.entries[index];
            return Column(
              children: [
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
                          CommonMontserratText(
                            text: 'Type: ${item.type}',
                            textSize: 12.sp,
                            color: AppColors.colorWhite,
                          ),
                          CommonMontserratText(
                            text: 'Amount: ${item.amount}',
                            textSize: 12.sp,
                            color: AppColors.colorWhite,
                          ),
                          CommonMontserratText(
                            text: 'Description: ${item.description}',
                            textSize: 12.sp,
                            color: AppColors.colorWhite,
                          ),
                          CommonMontserratText(
                            text: 'Date: ${item.date}',
                            textSize: 12.sp,
                            color: AppColors.colorWhite,
                          ),
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
                              controller.updateAmounts();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            );
          },
        ),
      );
    });
  }

  // Create side drawer view
  Drawer getDrawerView() {
    return Drawer(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60.h),
            Container(
              height: 80.w,
              width: 80.w,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.r), child: Image.network(StorageManager().getProfilePic().toString())),
            ),
            SizedBox(height: 20.h),
            CommonMontserratText(
                text: StorageManager().getName().toString(),
                textSize: 16.sp,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                fontWeight: AppFontWeight.medium),
            SizedBox(height: 10.h),
            CommonMontserratText(
              text: StorageManager().getEmail().toString(),
              textSize: 16.sp,
              fontWeight: AppFontWeight.medium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 50.h),
            CommonAppButton(
              text: 'Phase 2',
              width: 150.w,
              height: 40.h,
              fontWeight: AppFontWeight.bold,
              onClick: () {
             
              },
              borderRadius: 10.r,
            ),
            const Spacer(),
            CommonAppButton(
              text: 'Logout',
              width: 150.w,
              height: 40.h,
              onClick: () {
                controller.googleLogout();
              },
              borderRadius: 10.r,
            ),
            SizedBox(height: 20.h),
            CommonMontserratText(
              text: 'Version - 1.0.0',
              textSize: 16.sp,
              fontWeight: AppFontWeight.medium,
              color: Colors.grey,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
