import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cari Lokasi Anda"),
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildSmoothTextField(
                    controller: latitudeController,
                    label: "Lintang",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSmoothTextField(
                    controller: longitudeController,
                    label: "Bujur",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSmoothButton(
                    label: "Search Location",
                    onPressed: () {
                      final lat =
                          double.tryParse(latitudeController.text) ?? 0.0;
                      final lon =
                          double.tryParse(longitudeController.text) ?? 0.0;
                      controller.searchLocation(lat, lon);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSmoothButton(
                    label: "Navigate to Store",
                    onPressed: () {
                      double storeLat = -7.95304; // Koordinat toko -7.952148842379993, 112.6318176037021
                      double storeLon = 112.63167;
                      controller.navigateToStore(storeLat, storeLon);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
                  "Lokasi Saat ini: Lintang ${controller.latitude}, Bujur ${controller.longitude}",
                )),
            const SizedBox(height: 16),
            _buildSmoothButton(
              label: "Get My Location",
              onPressed: controller.getCurrentLocation,
            ),
            const SizedBox(height: 16),
            _buildSmoothButton(
              label: "Calculate Distance to Store",
              onPressed: () {
                // Ganti dengan koordinat toko
                double storeLat = -7.95304;
                double storeLon = 112.63167;
                controller.calculateDistanceToStore(storeLat, storeLon);
              },
            ),
            const SizedBox(height: 16),
            _buildSmoothButton(
              label: "Navigate to Store",
              onPressed: () {
                // Ganti dengan koordinat toko
                double storeLat = -7.95304;
                double storeLon = 112.63167;
                controller.navigateToStore(storeLat, storeLon);
              },
            ),
            const SizedBox(height: 16),
            _buildSmoothButton(
              label: "Start Real-Time Location Tracking",
              onPressed: controller.startLocationTracking,
            ),
            const SizedBox(height: 16),
            _buildSmoothButton(
              label: "Stop Real-Time Location Tracking",
              onPressed: controller.stopLocationTracking,
            ),
            const SizedBox(width: 16),
                 _buildSmoothButton(
                    label: "View Current Location on Map",
                    onPressed: controller.openUserLocationInMap,
                  ),
            // Tampilkan lokasi real-time
            Obx(() => Text(
              "Lokasi Saat ini: Lintang ${controller.latitude}, Bujur ${controller.longitude}",
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSmoothTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildSmoothButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
