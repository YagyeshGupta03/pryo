import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/IntroScreens/forgot_password_screen.dart';
import 'package:pryo_app/Screens/IntroScreens/no_connection_screen.dart';
import 'package:pryo_app/Screens/IntroScreens/terms_conditions_screen.dart';
import 'package:pryo_app/Screens/Login_screens/signup_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Controllers/Login_controller.dart';
import '../../../Widgets/common_widgets.dart';
import '../../../Widgets/password_field.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());


  @override
  initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Get.to(() => const NoConnectionScreen());
        credentialController.deleteData();
      } else {
        locationController.getLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // const Row( mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     LanguageDropdown(),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  HeadingText(
                    profileName: S.of(context).helloUser,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          icon: Icon(Icons.mail_outline,
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .iconTheme
                                  .color),
                          cont: _emailController,
                          hintText: S.of(context).emailAddress,
                          fillColor: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .cardColor,
                          keyboard: TextInputType.text,
                          fieldLabel: 'E-mail',
                          enable: true,
                        ),
                        const SizedBox(height: 15),
                        PasswordField(
                            cont: _passwordController,
                            hintText: S.of(context).password),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(() => const ForgotPassword());
                              },
                              child: Text(
                                S.of(context).forgotPassword,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: fontFamily,
                                    color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  LoginButton(
                    title: S.of(context).login,
                    onTap: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        connectivityController.connectedLogin(context);

                        // ignore: use_build_context_synchronously
                        _loginController.logInMail(context,
                            _emailController.text, _passwordController.text);
                        loadingController.updateLoading(false);
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).enterAllTheCredentials,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    },
                    txtColor: whiteColor,
                    btnColor: primaryColor,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).dontHaveAnAccount,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: Text(
                          S.of(context).signUp,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 80,
                  ),

                  // SizedBox(
                  //   width: 170,
                  //   child: Column(
                  //     children: [
                  //       Text('Or Continue With',
                  //           style: Provider.of<ThemeProvider>(context)
                  //               .currentTheme
                  //               .textTheme
                  //               .bodyMedium),
                  //       const SizedBox(height: 10),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           CircleButton(
                  //               onTap: () {
                  //                 // _loginController.signInWithFacebook();
                  //               },
                  //               image: 'assets/images/facebook.jpeg'),
                  //           CircleButton(
                  //             onTap: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       const PhoneLoginScreen(),
                  //                 ),
                  //               );
                  //             },
                  //             image: 'assets/images/Phone.png',
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).clickHereToReadOur,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .labelSmall,
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () async {
                          // _loginController.termsCondition().whenComplete(
                          //       () => Get.to(
                          //         () => const TermsAndConditions(),
                          //       ),
                          //     );

                          if (!await launchUrl(Uri.parse(termsWebApi))) {
                          throw Exception('Could not launch $termsWebApi');
                          }
                        },
                        child: Text(
                          S.of(context).termsOfService,
                          style: const TextStyle(
                              color: primaryColor, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).and,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .labelSmall),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () async {
                          // _loginController.privacyPolicy().whenComplete(
                          //       () => Get.to(
                          //         () => const PrivacyPolicy(),
                          //       ),
                          //     );
                          if (!await launchUrl(Uri.parse(privacyWebApi))) {
                          throw Exception('Could not launch $privacyWebApi');
                          }
                        },
                        child: Text(
                          S.of(context).privacyPolicies,
                          style: const TextStyle(
                              color: primaryColor, fontSize: 11),
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
        ],
      ),
    );
  }
}
