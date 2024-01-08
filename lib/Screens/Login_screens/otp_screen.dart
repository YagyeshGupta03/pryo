//
// import 'package:animated_snack_bar/animated_snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:pryo_app/Constants/colors.dart';
// import 'package:pryo_app/Constants/sizes.dart';
// import 'package:pryo_app/Screens/Sp_screens/sp_dashboard.dart';
// import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
// import '../../../Constants/theme_data.dart';
// import '../../../Widgets/common_widgets.dart';
// import '../../Controllers/global_controllers.dart';
//
// class OtpScreen extends StatefulWidget {
//   final String otp;
//   final String userType;
//   final String id;
//   const OtpScreen({Key? key, required this.otp, required this.userType, required this.id}) : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   String _pin = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//
//               Container(
//                 height: 120,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child:
//
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Text(
//                       'Verification Code',
//                       style: Provider.of<ThemeProvider>(context)
//                           .currentTheme
//                           .textTheme
//                           .displayLarge,
//                       textAlign: TextAlign.start,
//                     ),
//
//                     Text(
//                       'We Just Send You A Verify Code. Check \n Your Inbox To Get Them.',
//                       style: Provider.of<ThemeProvider>(context)
//                           .currentTheme
//                           .textTheme
//                           .displayMedium,
//                       textAlign: TextAlign.start,
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(
//                 height: 20,
//               ),
//
//               Text(
//                 'Your OTP is ${widget.otp}',
//                 style: Provider.of<ThemeProvider>(context)
//                     .currentTheme
//                     .textTheme
//                     .displayMedium,
//                 textAlign: TextAlign.start,
//               ),
//
//               const SizedBox(
//                 height: 20,
//               ),
//
//               SizedBox(
//                 width: screenWidth(context),
//                 child: OtpTextField(
//                   numberOfFields: 4,
//                   fillColor: otpFieldClr,
//                   borderColor: otpFieldClr,
//                   borderWidth: 0,
//                   fieldWidth: 50,
//                   showFieldAsBox: true,
//                   onSubmit: (val) {
//                     _pin = val;
//                     print(_pin);
//                   },
//                 ), // end onSubmit
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//
//               // LoginButton(
//               //   title: 'Continue',
//               //   onTap: () {
//               //     if (_pin == widget.otp) {
//               //       credentialController.setData(widget.id, widget.userType);
//               //       userInfoController.logInUserInfo(widget.id);
//               //       if (widget.userType == '1')
//               //       {Get.to(() => const HomeScreen());}
//               //       else {
//               //         Get.to(() => SpDashboardScreen());
//               //       }
//               //     } else {
//               //       AnimatedSnackBar.material(
//               //         'Invalid OTP',
//               //         type: AnimatedSnackBarType.success,
//               //         mobilePositionSettings: const MobilePositionSettings(
//               //           topOnAppearance: 50,
//               //         ),
//               //         mobileSnackBarPosition: MobileSnackBarPosition.top,
//               //       ).show(context);
//               //     }
//               //     ;
//               //   },
//               //   txtColor: txtColor,
//               //   btnColor: otpFieldClr,
//               // ),
//
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
//                     onPressed: () {},
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
//
//               const SizedBox(
//                 height: 40,
//               ),
//
//               SizedBox(
//                 width: 160,
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Or Continue With',
//                       style: TextStyle(fontSize: 16),
//                     ),
//
//                     const SizedBox(height: 10),
//
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
