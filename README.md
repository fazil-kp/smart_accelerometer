# Smart Accelerometer

<img src="https://cdn-icons-png.flaticon.com/512/11256/11256156.png" alt="Smart Accelerometer Dashboard" />

## Overview

Smart Accelerometer is a Flutter application that provides real-time visualization of accelerometer sensor data. The app displays acceleration values for all three axes (X, Y, Z) using intuitive gauge visualizations, making it easy to understand device orientation and movement.

## Features

- **Real-time Sensor Data**: Monitors and displays accelerometer readings as they happen
- **Three-Axis Visualization**: Individual gauges for X, Y, and Z axes with range from -10 to 10 m/s²
- **Color-Coded Interface**: Each axis has its own color for easy identification
  - X-axis (Red): Left/Right tilt
  - Y-axis (Green): Forward/Backward tilt
  - Z-axis (Blue): Vertical acceleration
- **Digital Readouts**: Quick-view numeric values for precise readings
- **Live Status Indicator**: Shows when sensor data is actively being collected
- **Recording Capability**: Save sensor data for later analysis
- **User-Friendly UI**: Clean design with intuitive controls and helpful information

## Installation

### Prerequisites

- Flutter SDK (2.5.0 or higher)
- Dart (2.14.0 or higher)
- Android Studio / VS Code with Flutter extensions
- A physical device (for accurate sensor readings)

### Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/fazil-kp/smart_accelerometer.git
   ```

2. Navigate to the project directory:
   ```bash
   cd smart_accelerometer
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `get`: State management
- `sensors_plus`: Access to device sensors
- `syncfusion_flutter_gauges`: Gauge visualizations

## Usage

1. Launch the app on a physical device
2. Hold the device in different orientations to see the values change
3. Use the "Refresh" button to reset the display if needed
4. Tap "Record" to start capturing sensor data (Premium feature)
5. Access the information panel for help understanding the readings

## Understanding the Readings

- **X-axis (Red)**: Measures left and right tilt
  - Positive values: Tilting right
  - Negative values: Tilting left

- **Y-axis (Green)**: Measures forward and backward tilt
  - Positive values: Tilting forward
  - Negative values: Tilting backward

- **Z-axis (Blue)**: Measures vertical acceleration
  - Positive values: Upward acceleration (or facing down)
  - Negative values: Downward acceleration (or facing up)
  - ~9.8 or ~-9.8: Device is stationary (Earth's gravity)

## Use Cases

- Physics experiments and demonstrations
- Fitness movement tracking
- Gaming input mechanism
- Vehicle dynamics monitoring
- Educational tool for understanding motion

## Troubleshooting

- **No readings or incorrect values**: Make sure you're using a physical device, not an emulator
- **Slow updates**: Check if other apps are using significant resources
- **App crashes**: Ensure your Flutter and dependency versions are compatible

## Future Enhancements

- Data export in CSV format
- Historical data graphs
- Calibration feature
- Customizable gauge ranges
- Multi-sensor fusion (gyroscope + accelerometer)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Flutter Sensors Documentation](https://flutter.dev)
- [Syncfusion Flutter Gauges](https://www.syncfusion.com/flutter-widgets/flutter-radial-gauge)
- [Material Design Guidelines](https://material.io/design)

---

**Note**: Replace the placeholder image at the top with an actual screenshot of your app before publishing.