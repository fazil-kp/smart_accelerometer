import 'dart:async';

import 'package:accelerometer_example/model/accelerometer_model.dart';
import 'package:get/get.dart';
import 'package:smart_accelerometer/accelerometer.dart';

class SensorController extends GetxController {
  /// Observable list that holds the latest accelerometer values (x, y, z).
  var accelerometerValues = [0.0, 0.0, 0.0].obs;

  /// Subscription for listening to accelerometer events.
  StreamSubscription<AccelerometerEvent>? subscription;

  /// List of accelerometer gauge configurations for UI representation.
  final List<AccelerometerModel> accelerometerGauges = [
    AccelerometerModel(title: 'X-Axis', minValue: -1, maxValue: 1, interval: 0.2),
    AccelerometerModel(title: 'Y-Axis', minValue: -1, maxValue: 1, interval: 0.2),
    AccelerometerModel(title: 'Z-Axis', minValue: -10, maxValue: 10, interval: 2),
  ];

  /// Initializes the controller and starts listening to accelerometer events.
  @override
  void onInit() {
    super.onInit();
    subscription = accelerometerEvents?.listen((event) {
      accelerometerValues.value = [event.x, event.y, event.z];
    });
  }

  /// Cancels the accelerometer event subscription when the controller is closed.
  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
