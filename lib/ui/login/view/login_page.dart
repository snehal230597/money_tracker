import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_tracker/app/app_colors.dart';
import 'package:money_tracker/app/app_font_weight.dart';
import 'package:money_tracker/ui/login/view/login_controller.dart';
import 'package:money_tracker/widgets/common_app_button.dart';
import 'package:money_tracker/widgets/common_text.dart';

class LogInPage extends GetView<LoginInController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: 155.h,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r))),
              child: Center(
                child: CommonMontserratText(
                    text: 'Money Tracker App',
                    textSize: 26.sp,
                    color: Colors.white,
                    fontWeight: AppFontWeight.bold),
              ),
            ),
            SizedBox(height: 150.h),
            Container(
              height: 80.h,
              width: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: CommonMontserratText(
                    text: ': Sign In :',
                    textSize: 26.sp,
                    fontWeight: AppFontWeight.bold),
              ),
            ),
            SizedBox(height: 150.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CommonAppButton(
                text: 'Sign In With Google',
                onClick: () {

                  controller.googleLoginWithFirebase();
                },
                showIcon: true,
                icon: Icon(
                  Icons.g_mobiledata,
                  color: Colors.yellow,
                  size: 40.w,
                ),
                borderRadius: 10.r,
              ),
            )
          ],
        ),
      ),
    );
  }
}
