import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  StreamSubscription<Position>? _positionStreamSubscription;

  void startLocationTracking(){
    Geolocator.isLocationServiceEnabled().then((serviceEnabled) async{
      if (!serviceEnabled){
        Get.snackbar('Error', 'Layanan Lokasi tidak dapat diaktifkan.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        Get.snackbar('Error', 'Permission lokasi ditolak.');
        return;
      }
    
      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high, // Akurasi tinggi
          distanceFilter: 1, // Perbarui jika jarak pengguna berubah 10 meter
        ),
      ).listen((Position position) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      });
    });
  }

  void stopLocationTracking(){
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  // Fungsi untuk mencari lokasi berdasarkan input
  void searchLocation(double lat, double lon) {
    latitude.value = lat;
    longitude.value = lon;
  }

  // Fungsi untuk mendapatkan lokasi pengguna
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied.';
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2){
    const double R = 6371;
    double dLat = (lat2 - lat1) * (pi / 180);
    double dLon = (lon2 - lon1) * (pi / 180);

    double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) * sin(dLon / 2 * sin(dLon / 2));

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c;

    return distance;
  }

  void calculateDistanceToStore(double storeLat, double storeLon){
    try {
      double distance = Geolocator.distanceBetween(
        latitude.value, 
        longitude.value, 
        storeLat, 
        storeLon,
        );

        Get.snackbar(
          'Jarak ke Toko', 
          'Jarak ke Toko: ${distance.toStringAsFixed(2)} km'
          );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghitung Jarak: $e'
        );
    }
  }

  void navigateToStore(double storeLat, double storeLon) async {
    final googleMapsUrl = 
    'https://www.google.com/maps/dir/?api=1&origin=${latitude.value},${longitude.value}&destination=$storeLat,$storeLon&travelmode=driving';

    if (await canLaunch(googleMapsUrl)){
      await launch(googleMapsUrl);
    } else {
      Get.snackbar(
        'Error', 
        'Tidak dapat membuka Google Maps.');
    }
  }

  void openUserLocationInMap() async {
    final googleMapsUrl = 
    'https://www.google.com/maps/dir/?api=1&origin=${latitude.value},${longitude.value}';

    if (await canLaunch(googleMapsUrl)){
      await launch(googleMapsUrl);
    } else {
      Get.snackbar(
        'Error', 
        'Tidak dapat membuka Google Maps.');
    }
  }
}