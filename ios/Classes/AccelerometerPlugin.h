#ifndef AccelerometerPlugin_h
#define AccelerometerPlugin_h

#import <Flutter/Flutter.h>

/**
 * AccelerometerPlugin is the main entry point for the Flutter plugin on iOS.
 * It implements the FlutterPlugin protocol, allowing it to be registered
 * with the Flutter engine and handle method calls from Dart.
 */
@interface AccelerometerPlugin : NSObject<FlutterPlugin>
@end

/**
 * CDYAccelerometerStreamHandler handles the accelerometer sensor data stream.
 * It implements the FlutterStreamHandler protocol, allowing it to send
 * continuous accelerometer updates to Flutter via an EventChannel.
 */
@interface CDYAccelerometerStreamHandler : NSObject<FlutterStreamHandler>
@end

#endif /* AccelerometerPlugin_h */
