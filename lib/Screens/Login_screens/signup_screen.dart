import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Controllers/Login_controller.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/Login_screens/id_upload_screen.dart';
import 'package:pryo_app/Widgets/password_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Constants/theme_data.dart';
import '../../../Widgets/common_widgets.dart';
import '../../Constants/all_urls.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullName = TextEditingController();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _city = TextEditingController();
  final _address = TextEditingController();
  String? _selectedItem;
  bool? checked;

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            loadingController.updateLoading(false);
            Get.to(() => const SignUpScreen());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // LanguageDropdown(),
                HeadingText(
                  profileName: S.of(context).helloUser,
                  // message: 'Signup For Better Experience',
                ),

                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButtonFormField(
                        hint: Text(
                          S.of(context).selectUserType,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .displaySmall,
                        ),
                        value: _selectedItem,
                        onChanged: (val) {
                          setState(() {
                            _selectedItem = val as String;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: '1',
                            child: Text(S.of(context).userMember),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text(S.of(context).serviceProvider),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      FormatterTextField(
                        icon: Icon(Icons.person_outline,
                            color: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .iconTheme
                                .color),
                        cont: _fullName,
                        fillColor: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .cardColor,
                        formatter: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s-]')),
                        hintText: S.of(context).fullName,
                        keyboard: TextInputType.text,
                        fieldLabel: 'Full Name',
                        enable: true,
                      ),
                      const SizedBox(height: 10),
                      FormatterTextField(
                          icon: Icon(Icons.person_outline,
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .iconTheme
                                  .color),
                          cont: _userName,
                          formatter: FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]')),
                          fillColor: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .cardColor,
                          hintText: S.of(context).userName,
                          keyboard: TextInputType.text,
                          fieldLabel: 'User Name',
                          enable: true),
                      const SizedBox(height: 10),
                      CustomTextField(
                          icon: Icon(Icons.mail_outline,
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .iconTheme
                                  .color),
                          cont: _email,
                          fillColor: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .cardColor,
                          hintText: S.of(context).emailAddress,
                          keyboard: TextInputType.text,
                          fieldLabel: 'E-mail',
                          enable: true),
                      const SizedBox(height: 10),
                      CustomTextField(
                          icon: Icon(Icons.location_city,
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .iconTheme
                                  .color),
                          cont: _city,
                          fillColor: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .cardColor,
                          hintText: S.of(context).city,
                          keyboard: TextInputType.text,
                          fieldLabel: 'City',
                          enable: true),
                      const SizedBox(height: 10),
                      CustomTextField(
                          icon: Icon(Icons.place,
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .iconTheme
                                  .color),
                          cont: _address,
                          fillColor: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .cardColor,
                          hintText: S.of(context).address,
                          keyboard: TextInputType.text,
                          fieldLabel: 'Address',
                          enable: true),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordField(
                          cont: _password, hintText: S.of(context).password),
                      const SizedBox(
                        height: 10,
                      ),
                      PhoneTextField(
                          icon: Icon(Icons.phone_in_talk_outlined,
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .iconTheme
                                  .color),
                          cont: _phone,
                          fillColor: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .cardColor,
                          hintText: S.of(context).phoneNumber,
                          keyboard: TextInputType.number,
                          fieldLabel: 'Number',
                          enable: true),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: checked ?? false,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  checked = val;
                                });
                                print(checked);
                              }),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).iHaveRead,
                                      style: Provider.of<ThemeProvider>(context)
                                          .currentTheme
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: () async {
                                        if (!await launchUrl(Uri.parse(termsWebApi))) {
                                        throw Exception('Could not launch $termsWebApi');
                                        }
                                      },
                                      child: Text(
                                        S.of(context).termsOfService,
                                        style: const TextStyle(
                                            color: primaryColor, fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(S.of(context).and,
                                        style:
                                            Provider.of<ThemeProvider>(context)
                                                .currentTheme
                                                .textTheme
                                                .titleSmall),
                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(Uri.parse(privacyWebApi))) {
                                    throw Exception('Could not launch $privacyWebApi');
                                    }
                                  },
                                  child: Text(
                                    S.of(context).privacyPolicies,
                                    style: const TextStyle(
                                        color: primaryColor, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                LoginButton(
                  title: _selectedItem == '2'
                      ? S.of(context).next
                      : S.of(context).signup,
                  onTap: () {
                    if (checked == true) {
                      if (_fullName.text.isNotEmpty &&
                          _userName.text.isNotEmpty &&
                          _password.text.isNotEmpty &&
                          _city.text.isNotEmpty &&
                          _email.text.isNotEmpty &&
                          _address.text.isNotEmpty &&
                          _selectedItem.toString().isNotEmpty &&
                          _phone.text.isNotEmpty) {
                        if (_email.text.isEmail && _phone.text.isPhoneNumber) {
                          if (_selectedItem == '2') {
                            Get.to(() => IdUploadScreen(
                                fullName: _fullName.text,
                                userName: _userName.text,
                                password: _password.text,
                                email: _email.text,
                                phone: _phone.text,
                                city: _city.text,
                                countryCode: codeOfCountry.toString(),
                                address: _address.text,
                                category: _selectedItem ?? ''));
                          } else {
                            _loginController.userSignUp(
                              context,
                              _fullName.text,
                              _userName.text,
                              _email.text,
                              _phone.text,
                              _password.text,
                              _city.text,
                              _address.text,
                              codeOfCountry.toString(),
                              _selectedItem.toString(),
                            );
                          }
                        } else {
                          AnimatedSnackBar.material(
                            S.of(context).enterValidDetails,
                            type: AnimatedSnackBarType.error,
                            mobilePositionSettings:
                                const MobilePositionSettings(
                              topOnAppearance: 50,
                            ),
                            mobileSnackBarPosition: MobileSnackBarPosition.top,
                          ).show(context);
                        }
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
                    } else {
                      Fluttertoast.showToast(
                        msg:
                            'Have you read terms of service and privacy policies?',
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  txtColor: whiteColor,
                  btnColor: primaryColor,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).alreadyHaveAnAccount,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .bodySmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(
                          () => const LoginScreen(),
                        );
                      },
                      child: Text(
                        S.of(context).logIn,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => loadingController.loading.value
              ? Center(
                  child: Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    color: Colors.black12,
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: primaryColor,
                      size: 50,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ]),
    );
  }
}
