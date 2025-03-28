import 'dart:async';
import 'package:flutter/services.dart';

/// Event channel for receiving accelerometer sensor data from the native platform.
const EventChannel _accelerometerEventChannel =
    EventChannel('fazi.com/accelerometer_sensor/accelerometer');

/// Represents an event containing accelerometer sensor data.
class AccelerometerEvent {
  /// Acceleration force along the x-axis (including gravity) measured in m/s².
  /// (X-axis: Left and right movement)
  final double x;

  /// Acceleration force along the y-axis (including gravity) measured in m/s².
  /// (Y-axis: Forward and backward movement)
  final double y;

  /// Acceleration force along the z-axis (including gravity) measured in m/s².
  /// (Z-axis: Up and down movement)
  final double z;

  /// Constructor to initialize accelerometer event values.
  AccelerometerEvent(this.x, this.y, this.z);

  /// Returns a string representation of the accelerometer event.
  @override
  String toString() => '[AccelerometerEvent (x: $x, y: $y, z: $z)]';
}

/// Converts a list of double values into an [AccelerometerEvent] object.
AccelerometerEvent _listToAccelerometerEvent(List<double> list) {
  return AccelerometerEvent(list[0], list[1], list[2]);
}

/// A broadcast stream of accelerometer events from the device.
/// This listens to the event channel and streams accelerometer data to Flutter.
Stream<AccelerometerEvent>? _accelerometerEvents;

/// Getter to retrieve the accelerometer event stream.
/// If the stream is null, it initializes and maps the native sensor data to [AccelerometerEvent] objects.
Stream<AccelerometerEvent>? get accelerometerEvents {
  if (_accelerometerEvents == null) {
    _accelerometerEvents = _accelerometerEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToAccelerometerEvent(event.cast<double>()));
  }
  return _accelerometerEvents;
}
