import 'package:get_storage/get_storage.dart';

/// Storage manager to store and retrieve data from local storage
class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  final String email = 'userEmail';
  final String fullName = 'full_name';
  final String profilePic = 'profile_pic';

  GetStorage localStorage = GetStorage();


  /// Set user email
  void setEmail(String userEmail) {
    localStorage.write(email, userEmail);
  }

  String? getEmail() {
    return localStorage.read(email);
  }

  /// Clear all data stored in local
  void clearSession() {
    localStorage.erase();
  }

  /// Set user name
  void setName(String userName) {
    localStorage.write(fullName, userName);
  }

  String? getName() {
    return localStorage.read(fullName);
  }

  /// Set user profilePic
  void setProfilePic(String userProfilePic) {
    localStorage.write(profilePic, userProfilePic);
  }

  String? getProfilePic() {
    return localStorage.read(profilePic);
  }
}
