import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  StreamSubscription<Position>? streamSubscription;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getLocation();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  //   getLocation();
  // }


  @override
  void onClose() {
    streamSubscription!.cancel();
  }

  getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // await Geolocator.openLocationSettings();
      if (permission == LocationPermission.denied) {
        return Future.error('Location services are disabled.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (streamSubscription == null || streamSubscription!.isPaused) {
      streamSubscription =
          Geolocator.getPositionStream().listen((Position position) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
        update();
      });
    }
  }
}
