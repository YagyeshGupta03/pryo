import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({Key? key}) : super(key: key);

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  final _editFullName = TextEditingController(text: userInfoController.fullName.value);
  final _editCity = TextEditingController(text: userInfoController.city.value);
  final _editAddress = TextEditingController(text: userInfoController.address.value);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.to(() => const HomeScreen());
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .iconTheme
                  .color,
            ),
          ),
          title: Center(
            child: Text(
              S.of(context).editProfile,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .bodyMedium,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                FormatterUserFields(
                    text: S.of(context).fullName,
                    formatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s-]')),
                    hintText: userInfoController.fullName.value,
                    fieldLabel: 'Name',
                    keyboard: TextInputType.text,
                    controller: _editFullName,
                    enable: true),
                const SizedBox(height: 20),
                // UserFields(
                //     text: '  E-Mail',
                //     fieldLabel: 'E-mail',
                //     keyboard: TextInputType.text,
                //     hintText: userInfoController.email.value,
                //     controller: _textController.editMail.value,
                //     enable: false),
                // const SizedBox(height: 20),
                // UserFields(
                //     text: '  Phone Number',
                //     fieldLabel: 'Number',
                //     keyboard: TextInputType.number,
                //     hintText:  userInfoController.phone.value,
                //     controller: _textController.editPhone.value,
                //     enable: false),
                // const SizedBox(height: 20),
                UserFields(
                    text: S.of(context).city,
                    fieldLabel: 'City',
                    hintText:  userInfoController.city.value,
                    keyboard: TextInputType.text,
                    controller: _editCity,
                    enable: true),
                const SizedBox(height: 20),
                UserFields(
                    text: S.of(context).streetIncludeHouseNumber,
                    fieldLabel: 'Street',
                    keyboard: TextInputType.text,
                    hintText:  userInfoController.address.value,
                    controller:_editAddress,
                    enable: true),
                const SizedBox(height: 30),
                LoginButton(
                    onTap: () {
                      if(_editFullName.text.isNotEmpty && _editAddress.text.isNotEmpty && _editCity.text.isNotEmpty)
                      {
                        _profileController.userProfile(
                            context,
                            _editFullName.text,
                            _editCity.text,
                            _editAddress.text);
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).kindlyFillAllTheMandatoryFields,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    },
                    title: S.of(context).update,
                    txtColor: Colors.white,
                    btnColor: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
