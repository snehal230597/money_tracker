import 'package:get/get.dart';
import 'package:money_tracker/ui/add_entries/binding/add_entries_binding.dart';
import 'package:money_tracker/ui/add_entries/view/add_entries_view.dart';
import 'package:money_tracker/ui/all_transaction/binding/all_transaction_binding.dart';
import 'package:money_tracker/ui/all_transaction/view/all_transaction_view.dart';
import 'package:money_tracker/ui/home/binding/home_binding.dart';
import 'package:money_tracker/ui/home/view/home_page.dart';
import 'package:money_tracker/ui/login/binding/login_binding.dart';
import 'package:money_tracker/ui/login/view/login_page.dart';

/// All routes for app pages are defined here
class AppRoutes {
  static const initialRoute = '/login_page';
  static const dashboardPage = '/dashboard_page';
  static const addEntriesPage = '/add_entries_page';
  static const homePage = '/home_page';
  static const allTransactionPage = '/all_transaction_page';


  static final List<GetPage> pages = [

    GetPage(
      name: AppRoutes.initialRoute,
      page: () => const LogInPage(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: AppRoutes.allTransactionPage,
      page: () =>const AllTransactionPage(),
      binding: AllTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.addEntriesPage,
      page: () =>const AddEntriesPage(),
      binding: AddEntriesBinding(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),

  ];
}
