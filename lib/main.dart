

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/IntroScreens/splash_screen.dart';
import 'generated/l10n.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Request permission
  // NotificationSettings settings = await messaging.requestPermission(
  // alert: true,
  // badge: true,
  // sound: true,
  // );
  credentialController.getTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // ChangeNotifierProvider(create: (_) => WordProvider()),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    final LanguageController _languageController = Get.put(LanguageController());
    return GetMaterialApp(
      title: 'Pryo App',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(_languageController.currentLanguage.toString()),
      supportedLocales: S.delegate.supportedLocales,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//
