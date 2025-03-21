import 'package:accelerometer_example/config/colors.dart';
import 'package:accelerometer_example/config/theme.dart';
import 'package:accelerometer_example/controller/sensor_controller.dart';
import 'package:accelerometer_example/helper/extensions.dart';
import 'package:accelerometer_example/view/accelerometer/src/accelerometer_gauge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccelerometerContent extends StatelessWidget {
  final SensorController sensorController;
  const AccelerometerContent({super.key, required this.sensorController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final accelerometer = sensorController.accelerometerValues;
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sensors, color: primary, size: 28),
                  15.width,
                  Text('Accelerometer Data', style: context.bodySmall?.copyWith(color: secondary, fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              20.height,
              SizedBox(
                height: context.smartHeight() - 165,
                width: context.smartWidth(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: List.generate(sensorController.accelerometerGauges.length, (e) => AccelerometerGauge(model: sensorController.accelerometerGauges[e], value: accelerometer[e])),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
