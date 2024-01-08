import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/Login_controller.dart';
import '../../generated/l10n.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key, required this.mail, required this.otP, required this.oldPassword}) : super(key: key);

  final String mail;
  final String otP;
  final String oldPassword;

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());
    final _pass = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(()=> const LoginScreen());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Text(
          S.of(context).forgotPassword,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .bodyMedium,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            UserFields(
                text: S.of(context).password,
                hintText: S.of(context).enterNewPassword,
                controller: _pass,
                enable: true,
                fieldLabel: 'password',
                keyboard: TextInputType.text),
            const SizedBox(height: 20),
            LoginButton(
                onTap: () {
                  if(_pass.text.isNotEmpty) {
                    _loginController.passwordEnter(context, mail, otP, _pass.text, oldPassword);
                  } else {
                    AnimatedSnackBar.material(
                      S.of(context).fieldIsEmpty,
                      type: AnimatedSnackBarType.error,
                      mobilePositionSettings: const MobilePositionSettings(
                        topOnAppearance: 50,
                      ),
                      mobileSnackBarPosition: MobileSnackBarPosition.top,
                    ).show(context);
                  }
                },
                title: S.of(context).save,
                txtColor: Colors.white,
                btnColor: primaryColor)
          ],
        ),
      ),
    );
  }
}
