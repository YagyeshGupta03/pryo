import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import '../../Constants/theme_data.dart';
import 'no_connection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    connectivityController.connectionChecking(context);
    // locationController.getLocation();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      credentialController.getData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      credentialController.getData();
    } else if (connectivityResult == ConnectivityResult.none) {
      Get.to(() => const NoConnectionScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return credentialController.theme
        ? Container(
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .primaryColorDark,
              image: const DecorationImage(
                image: AssetImage('assets/images/Pattern.png'),
              ),
            ),
            child: Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .primaryColorDark,
              image: const DecorationImage(
                image: AssetImage('assets/images/Pattern.png'),
              ),
            ),
            child: Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/images/logoDark.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}
