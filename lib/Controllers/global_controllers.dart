import 'package:get/get.dart';
import 'package:pryo_app/Controllers/connectivity_controller.dart';
import 'package:pryo_app/Controllers/credential_controller.dart';
import 'package:pryo_app/Controllers/location_controller.dart';
import 'common_controllers.dart';
import 'firebase_controller.dart';

final CredentialController credentialController =
Get.put(CredentialController());

final BnbController bnbController = Get.put(BnbController());

final ThemeController themeController = Get.put(ThemeController());

final ConnectivityController connectivityController = Get.put(ConnectivityController());

final UserInfoController userInfoController = Get.put(UserInfoController());

final LocationController locationController = Get.put(LocationController());

final LoadingController loadingController = Get.put(LoadingController());

final FavoriteController favoriteController = Get.put(FavoriteController());

final FirebaseController firebase = Get.put(FirebaseController());

