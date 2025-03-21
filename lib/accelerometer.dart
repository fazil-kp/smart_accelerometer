import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _accelerometerEventChannel = EventChannel('fazi.com/accelerometer_sensor/accelerometer');

class AccelerometerEvent {
  //! Acceleration force along the x axis (including gravity) measured in m/s^2.
  final double x;

  //! Acceleration force along the y axis (including gravity) measured in m/s^2.
  final double y;

  //! Acceleration force along the z axis (including gravity) measured in m/s^2.
  final double z;

  AccelerometerEvent(this.x, this.y, this.z);

  @override
  String toString() => '[AccelerometerEvent (x: $x, y: $y, z: $z)]';
}

AccelerometerEvent _listToAccelerometerEvent(List<double> list) {
  return AccelerometerEvent(list[0], list[1], list[2]);
}

Stream<AccelerometerEvent>? _accelerometerEvents;

//! A broadcast stream of events from the device accelerometer.
Stream<AccelerometerEvent>? get accelerometerEvents {
  if (_accelerometerEvents == null) {
    _accelerometerEvents = _accelerometerEventChannel.receiveBroadcastStream().map((dynamic event) => _listToAccelerometerEvent(event.cast<double>()));
  }
  return _accelerometerEvents;
}
