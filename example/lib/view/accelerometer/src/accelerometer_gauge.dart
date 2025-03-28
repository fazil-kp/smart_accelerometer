import 'package:accelerometer_example/config/colors.dart';
import 'package:accelerometer_example/config/theme.dart';
import 'package:accelerometer_example/helper/extensions.dart';
import 'package:accelerometer_example/model/accelerometer_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AccelerometerGauge extends StatelessWidget {
  final AccelerometerModel model;
  final double value;
  const AccelerometerGauge({Key? key, required this.model, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(model.title, style: context.bodySmall?.copyWith(color: secondary, fontSize: 14, fontWeight: FontWeight.w500)),
        15.height,
        SizedBox(
          height: 220,
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            axes: <RadialAxis>[
              RadialAxis(
                minimum: model.minValue,
                maximum: model.maxValue,
                interval: model.interval,
                startAngle: 180,
                showLabels: true,
                showTicks: true,
                labelOffset: 10,
                majorTickStyle: MajorTickStyle(length: 8, thickness: 2, color: ashColor),
                minorTickStyle: MinorTickStyle(length: 4, thickness: 1, color: ashColor),
                axisLineStyle: AxisLineStyle(thickness: 0.03, thicknessUnit: GaugeSizeUnit.factor, color: ashColor),
                pointers: <GaugePointer>[NeedlePointer(value: value, needleLength: 0.6, needleStartWidth: 1, needleEndWidth: 5, knobStyle: KnobStyle(knobRadius: 0.05, color: secondary))],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
