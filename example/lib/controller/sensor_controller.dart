import 'dart:async';

import 'package:accelerometer_example/model/accelerometer_model.dart';
import 'package:get/get.dart';
import 'package:smart_accelerometer/accelerometer.dart';

class SensorController extends GetxController {
  var accelerometerValues = <double>[0.0, 0.0, 0.0].obs;
  StreamSubscription<AccelerometerEvent>? subscription;

  final List<AccelerometerModel> accelerometerGauges = [
    AccelerometerModel(title: 'X-Axis', minValue: -1, maxValue: 1, interval: 0.2),
    AccelerometerModel(title: 'Y-Axis', minValue: -1, maxValue: 1, interval: 0.2),
    AccelerometerModel(title: 'Z-Axis', minValue: -10, maxValue: 10, interval: 2),
  ];

  @override
  void onInit() {
    super.onInit();
    subscription = accelerometerEvents!.listen((event) {
      accelerometerValues.value = [event.x, event.y, event.z];
    });
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
