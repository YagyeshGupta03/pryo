import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/Login_controller.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFFFE6D0B).withOpacity(0.30),
        title: Obx(
          () => Text(
            _loginController.title.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: fontFamily,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Html(
                  data: _loginController.description.value.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
//
//
//
//
//
class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFFFE6D0B).withOpacity(0.30),
        title: Obx(
          () => Text(
            _loginController.pTitle.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: fontFamily,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Html(
                  data: _loginController.pDescription.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
