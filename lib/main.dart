import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_tracker/app/app_class.dart';
import 'package:money_tracker/app/app_colors.dart';
import 'package:money_tracker/app/app_routes.dart';
import 'package:money_tracker/app/app_theme.dart';
import 'package:money_tracker/data/local/session_manager.dart';
import 'package:money_tracker/widgets/common_progress_indicator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  String? isEmail = StorageManager().getEmail(); // Check if user already logged in

  Get.put(AppColors());
  runApp(
    MyApp(
      initialRoute: isEmail == null ? AppRoutes.initialRoute : AppRoutes.homePage,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppTheme.designSize,
      builder: (_, widget) => GetMaterialApp(

        enableLog: true,
        title: 'Money Tracker App',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
        ),
        darkTheme: ThemeData.light(),
        themeMode: ThemeMode.light,
        builder: (context, widget) => getMainAppViewBuilder(context, widget),
        getPages: AppRoutes.pages,
        initialRoute: initialRoute,
      ),
    );
  }

  /// Create main app view builder
  Widget getMainAppViewBuilder(BuildContext context, Widget? widget) {
    return Obx(
          () {
        return IgnorePointer(
          ignoring: AppClass().isShowLoading.isTrue,
          child: Stack(
            children: [
              widget ?? const Offstage(),
              if (AppClass().isShowLoading.isTrue) // Top level loading ( used while api calls)
                ColoredBox(
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(
                    child: CommonProgressIndicator(color: AppColors.primaryColor),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

//SHA 1 : 53:47:FE:F4:35:BF:2E:01:D1:E0:C6:DC:33:B4:43:CB:33:9A:82:02
//SHA 256 : 08:42:A3:C3:6B:6B:B0:B6:07:FC:C0:71:E4:9C:17:F6:BB:3B:44:E0:46:EE:5B:8F:AB:00:A9:4C:6C:C8:15:DA