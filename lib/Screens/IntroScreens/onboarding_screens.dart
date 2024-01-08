import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/common_controllers.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import '../../Constants/all_urls.dart';
import '../../generated/l10n.dart';

class IntroSlide1 extends StatefulWidget {
  const IntroSlide1({Key? key}) : super(key: key);

  @override
  State<IntroSlide1> createState() => _IntroSlide1State();
}

class _IntroSlide1State extends State<IntroSlide1> {
  final OnboardController _onboardController = Get.put(OnboardController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroSlide2(),
            ),
          );
        },
        image: _onboardController.image1.toString(),
        slider: 'assets/images/Onboarding/slide1.png',
        title: _onboardController.title1,
        subTitle: _onboardController.description1);
  }
}

//
//
//
//
//
class IntroSlide2 extends StatelessWidget {
  const IntroSlide2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnboardController _onboardController = Get.put(OnboardController());
    return OnBoardingScreen(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroSlide3(),
          ),
        );
      },
      image: _onboardController.image2.toString(),
      title: _onboardController.title2,
      subTitle: _onboardController.description2,
      slider: 'assets/images/Onboarding/slide2.png',
    );
  }
}

//
//
//
//
//
class IntroSlide3 extends StatelessWidget {
  const IntroSlide3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void dialogInfo(context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'PRYO collects location data to show your nearby service providers/users.\n \n Provide location information of this device to PRYO?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Deny',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                onPressed: () {
                  Get.to(() => const NoPermissionScreen());
                },
              ),
              TextButton(
                  child: const Text('Accept',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  onPressed: () {
                    credentialController.setOnboard('2');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }),
            ],
          );
        },
      );
    }

    final OnboardController _onboardController = Get.put(OnboardController());
    return OnBoardingScreen(
        onTap: () {
          dialogInfo(context);
        },
        image: _onboardController.image3.toString(),
        slider: 'assets/images/Onboarding/slide3.png',
        title: _onboardController.title3,
        subTitle: _onboardController.description3);
  }
}

//
//
//
class NoPermissionScreen extends StatelessWidget {
  const NoPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 15),
            const Text(
              'Location permissions are required to access this app.',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(() => const IntroSlide3());
              },
              child: const Text(
                'Go back',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen(
      {Key? key,
      required this.onTap,
      required this.image,
      required this.slider,
      required this.title,
      required this.subTitle})
      : super(key: key);

  final Function onTap;
  final String image;
  final String slider;
  final String title;
  final String subTitle;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  void dialogInfo(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'PRYO collects location data to show your nearby service providers/users.\n \n Provide location information of this device to PRYO?',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Deny',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              onPressed: () {
                Get.to(() => const NoPermissionScreen());
              },
            ),
            TextButton(
                child: const Text('Accept',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
                onPressed: () {
                  credentialController.setOnboard('2');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/images/halfCircle.png'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    dialogInfo(context);
                  },
                  child: Container(
                    height: 35,
                    width: 75,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: whiteTheme.cardColor),
                    child: Center(
                      child: Text(
                        S.of(context).skip,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .labelMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 350,
              width: screenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('$onboardingImage${widget.image}'),
                    fit: BoxFit.fill),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 10,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.slider), fit: BoxFit.fill),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                right: 25,
                left: 25,
              ),
              child: Text(
                widget.title,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .headline1,
                textAlign: TextAlign.justify,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 25, left: 25, top: 15, bottom: 25),
              child: Text(
                widget.subTitle,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .displaySmall,
                textAlign: TextAlign.justify,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: () {
                widget.onTap();
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
