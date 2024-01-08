import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../Constants/theme_data.dart';
import '../generated/l10n.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController _profileController = Get.put(ProfileController());

    final _oldPass = TextEditingController();
    final _newPass = TextEditingController();
    final _confirmPass = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserFields(
                  text: S.of(context).oldPassword,
                  hintText: S.of(context).enterYourExistingPassword,
                  controller: _oldPass,
                  enable: true,
                  fieldLabel: 'password',
                  keyboard: TextInputType.text),
              const SizedBox(height: 20),
              UserFields(
                  text: S.of(context).newPassword,
                  hintText: S.of(context).enterNewPassword,
                  controller: _newPass,
                  enable: true,
                  fieldLabel: 'password',
                  keyboard: TextInputType.text),
              const SizedBox(height: 20),
              UserFields(
                  text: S.of(context).confirmPassword,
                  hintText: S.of(context).confirmYourPassword,
                  controller: _confirmPass,
                  enable: true,
                  fieldLabel: 'password',
                  keyboard: TextInputType.text),
              const SizedBox(height: 30),
              LoginButton(
                  onTap: () {
                    if (_oldPass.text.isNotEmpty &&
                        _confirmPass.text.isNotEmpty &&
                        _newPass.text.isNotEmpty) {
                      if (_newPass.text == _confirmPass.text) {
                        _profileController.changePassword(context,
                            _oldPass.text, _newPass.text, _confirmPass.text);
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).passwordConfirmationDoesNotMatch,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    } else {
                      AnimatedSnackBar.material(
                        S.of(context).fillAllTheFields,
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
      ),
    );
  }
}
