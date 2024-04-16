import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_tracker/app/app_colors.dart';
import 'package:money_tracker/app/app_font_weight.dart';
import 'package:money_tracker/data/model/add_entry_model.dart';
import 'package:money_tracker/ui/add_entries/view/add_entries_controller.dart';
import 'package:money_tracker/utility/utils.dart';
import 'package:money_tracker/widgets/common_app_button.dart';
import 'package:money_tracker/widgets/common_app_input.dart';
import 'package:money_tracker/widgets/common_text.dart';

class AddEntriesPage extends GetView<AddEntriesController> {
  const AddEntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          Utils.closeKeyboard();
        },
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            backgroundColor: AppColors.colorBlack,
            title: CommonMontserratText(
              text: "Add Entries",
              textSize: 16.sp,
              fontWeight: AppFontWeight.bold,
              color: AppColors.colorWhite,
            ),
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                //  height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 30.w),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Earnings'),
                            activeColor: AppColors.colorBlack,
                            value: 'earnings',
                            contentPadding: EdgeInsets.zero,
                            groupValue: controller.selectedValue.value,
                            onChanged: (value) {
                              controller.selectValue(value);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Expenses'),
                            activeColor: AppColors.colorBlack,
                            contentPadding: EdgeInsets.zero,
                            value: 'expenses',
                            groupValue: controller.selectedValue.value,
                            onChanged: (value) {
                              controller.selectValue(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.w),
                    CommonAppInput(
                        textEditingController: controller.amountController,
                        hintText: 'Amount',
                        maxLength: 3,
                        isAmount: true,
                        textInputType: TextInputType.number),
                    SizedBox(height: 20.w),
                    CommonAppInput(
                        textEditingController: controller.descriptionController,
                        hintText: 'Description',
                        maxLength: 10,
                        textInputType: TextInputType.text),
                    SizedBox(height: 20.w),
                    Container(
                      height: 50.h,
                      width: Get.width,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonMontserratText(
                                text: controller.selectedDate.value.toString(),
                                textSize: 16.sp,
                                color: Colors.grey,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.openDatePicker();
                                },
                                child: Icon(
                                  Icons.calendar_month,
                                  size: 25.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.w),
                    CommonAppButton(
                        text: 'Add',
                        fontWeight: AppFontWeight.bold,
                        onClick: () {
                          controller.insert();

                        },
                        borderRadius: 10.r),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
