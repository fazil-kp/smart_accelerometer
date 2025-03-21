import 'package:accelerometer_example/config/colors.dart';
import 'package:accelerometer_example/config/theme.dart';
import 'package:accelerometer_example/controller/sensor_controller.dart';
import 'package:accelerometer_example/view/accelerometer/src/accelerometer_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccelerometerScreen extends StatelessWidget {
  const AccelerometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SensorController sensorController = Get.put(SensorController());
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(title: Text('Sensor Dashboard', style: context.bodySmall?.copyWith(color: background, fontSize: 22, fontWeight: FontWeight.bold)), elevation: 2, backgroundColor: primary, centerTitle: true),
      body: AccelerometerContent(sensorController: sensorController),
    );
  }
}
