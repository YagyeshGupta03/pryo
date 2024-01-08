import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pryo_app/Screens/IntroScreens/onboarding_screens.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_dashboard.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_controllers.dart';
import 'global_controllers.dart';

class CredentialController extends GetxController {
  String? id;
  String? userType;
  String? onboard;
  bool theme = true;
  String word = 'sv';

  //
  //
  //
  //
  void setData(userID, Type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', userID);
    await prefs.setString('type', Type);
    id = prefs.getString('id');
    userType = prefs.getString('type');
  }

  //
  //
  //
  //
  void setOnboard(onboard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('onboard', onboard);
    onboard = prefs.getString('onboard');
  }

  //
  //
  //
  //
  setLanguage(language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('words', language);
    word = prefs.getString('words') ?? 'sv';
    update();
  }

  //
  //
  //
  //
  void addTheme(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', val);
    theme = prefs.getBool('theme') ?? true;
  }

  //
  //
  //
  //
  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = prefs.getBool('theme') ?? true;
    word = prefs.getString('words') ?? 'sv';
    update();
  }

  //
  //
  //
  //
  final OnboardController _onboardController = Get.put(OnboardController());
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? "";
    userType = prefs.getString('type') ?? "";
    onboard = prefs.getString('onboard') ?? '1';

    if (id == '') {
      if (onboard == '1') {
        _onboardController.onboardUpdate().then((value) {Get.to(
                () => const IntroSlide1()
        );});
      } else if (onboard == '2') {
        Get.to(() => const LoginScreen());
      }
    } else if (id.toString().isNotEmpty) {
      if (userType == '1') {
        userInfoController.getUserInfo().whenComplete(
              () => Get.off(() => const HomeScreen()),
            );
      } else if (userType == '2') {
        userInfoController.getUserInfo();
        Get.off(
          () => SpDashboardScreen(userID: id.toString()),
        );
      }
    }
  }

  //
  //
  //
  //
  void deleteData() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', '');
    await prefs.setString('type', '');
    id = '';
    userType = '';
    update();
  }

  //
  //
  //
  //
  //
  void getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  //
  //
  //
  //
  void refreshData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id != null) {
      if (userType == '1') {
        Get.to(() => const HomeScreen());
      } else if (userType == '2') {
        Get.to(() => SpDashboardScreen(
              userID: id.toString(),
            ));
      }
    } else {
      Get.to(() => const LoginScreen());
      //  redirect user to login screen
    }
  }
}
