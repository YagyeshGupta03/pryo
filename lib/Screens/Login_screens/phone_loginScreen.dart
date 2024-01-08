// import 'package:animated_snack_bar/animated_snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:pryo_app/Constants/colors.dart';
// import 'package:pryo_app/Constants/sizes.dart';
// import 'package:pryo_app/Screens/Login_screens/signup_screen.dart';
// import '../../../Constants/theme_data.dart';
// import '../../../Controllers/Login_controller.dart';
// import '../../../Widgets/common_widgets.dart';
//
// class PhoneLoginScreen extends StatefulWidget {
//   const PhoneLoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
// }
//
// class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
//   final _phone = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final LoginController _loginController = Get.put(LoginController());
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // LanguageDropdown(),
//               const HeadingText(
//                 profileName: 'Hello Sara!',
//                 message: 'Welcome Back, You Have Been \n Missed For Long Time ',
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: screenWidth(context),
//                 child: PhoneTextField(
//                   controller: _phone,
//                   showCountryCodeAsIcon: true,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 10),
//                     enabledBorder: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10.0),
//                         ),
//                         borderSide: BorderSide(color: whiteColor)),
//                     focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10.0),
//                       ),
//                       borderSide: BorderSide(color: whiteColor),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.phone,
//                       color: Provider.of<ThemeProvider>(context)
//                           .currentTheme
//                           .iconTheme
//                           .color,
//                     ),
//                     labelText: "Phone number",
//                     labelStyle: Provider.of<ThemeProvider>(context)
//                         .currentTheme
//                         .textTheme
//                         .displayMedium,
//                   ),
//                   searchFieldInputDecoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.transparent,
//                     enabledBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(),
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(),
//                     ),
//                     suffixIcon: Icon(
//                       Icons.search,
//                       color: Provider.of<ThemeProvider>(context)
//                           .currentTheme
//                           .iconTheme
//                           .color,
//                     ),
//                     hintText: "Search country",
//                     labelStyle: Provider.of<ThemeProvider>(context)
//                         .currentTheme
//                         .textTheme
//                         .displayMedium,
//                     hintStyle: Provider.of<ThemeProvider>(context)
//                         .currentTheme
//                         .textTheme
//                         .displaySmall,
//                   ),
//                   initialCountryCode: "IN",
//                   onChanged: (phone) {
//                     debugPrint(phone.completeNumber);
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               LoginButton(
//                 title: 'Login',
//                 txtColor: whiteColor,
//                 btnColor: primaryColor,
//                 onTap: () {
//                   if (_phone.text.isPhoneNumber) {
//                     _loginController.logInPhone(context, _phone.text);
//
//                   } else {
//                     AnimatedSnackBar.material(
//                       'Enter a valid phone number',
//                       type: AnimatedSnackBarType.error,
//                       mobilePositionSettings: const MobilePositionSettings(
//                         topOnAppearance: 50,
//                       ),
//                       mobileSnackBarPosition: MobileSnackBarPosition.top,
//                     ).show(context);
//                   }
//                 },
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an account?",
//                     style: Provider.of<ThemeProvider>(context)
//                         .currentTheme
//                         .textTheme
//                         .bodySmall,
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Get.to(()=> const SignUpScreen());
//                     },
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: primaryColor),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               SizedBox(
//                 width: 160,
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Or Continue With',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             color: circleClr,
//                             borderRadius: BorderRadius.circular(500),
//                             image: const DecorationImage(
//                               image: AssetImage('assets/images/facebook.jpeg'),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             color: circleClr,
//                             borderRadius: BorderRadius.circular(500),
//                             image: const DecorationImage(
//                               image: AssetImage('assets/images/mail.png'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
