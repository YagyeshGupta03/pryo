// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/IntroScreens/no_connection_screen.dart';
import '../generated/l10n.dart';


class ConnectivityController extends GetxController {

  Future connectionChecking(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else if (connectivityResult == ConnectivityResult.none) {
      AnimatedSnackBar.material(
        S.of(context).noInternetConnection,
        type: AnimatedSnackBarType.error,
        mobilePositionSettings: const MobilePositionSettings(
          topOnAppearance: 50,
        ),
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
    }
  }

  Future connectedLogin(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else if (connectivityResult == ConnectivityResult.none) {
      Get.to(() => const NoConnectionScreen());
    }
  }

  Future refreshConnection(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      credentialController.refreshData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      credentialController.refreshData();
    } else if (connectivityResult == ConnectivityResult.none) {}
  }
}
