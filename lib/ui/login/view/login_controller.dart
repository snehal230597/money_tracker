

import 'package:money_tracker/app/app_class.dart';
import 'package:money_tracker/data/local/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_tracker/app/app_routes.dart';

class LoginInController extends GetxController {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxString imageUrl = "".obs;
  RxString userName = "".obs;
  RxString email = "".obs;
  RxString name = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  googleLoginWithFirebase() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    AppClass().showLoading(true);
    try {
      var result = await googleSignIn.signIn();
      final userData = await result?.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: userData?.accessToken, idToken: userData?.idToken);
      var finalResult = await FirebaseAuth.instance.signInWithCredential(credential);

      if (result == null) {
        return;
      } else {
        imageUrl.value = result.photoUrl ?? "";
        userName.value = result.displayName ?? "";
        email.value = result.email ?? "";

        StorageManager().setEmail(email.value);
        StorageManager().setName(userName.value);
        StorageManager().setProfilePic(imageUrl.value);

        AppClass().showLoading(false);
        Get.toNamed(AppRoutes.homePage, /*arguments: data*/);

      }
      print("Result === $result");
    } catch (error) {
      print(error);
    }
  }

// used for logout in Android Platform
  Future<void> googleLogout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    StorageManager().clearSession();
    Get.back();
  }
}
