#import <Foundation/Foundation.h>
#import "AccelerometerPlugin.h"
#import <CoreMotion/CoreMotion.h>

@implementation AccelerometerPlugin

/**
 * Registers the plugin with the Flutter engine.
 *
 * @param registrar The FlutterPluginRegistrar that allows the plugin to register
 *                  itself with the Flutter framework.
 */
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    // Create an instance of the stream handler to manage accelerometer data streaming.
    CDYAccelerometerStreamHandler* accelerometerStreamHandler = [[CDYAccelerometerStreamHandler alloc] init];
    
    // Create a Flutter event channel for streaming accelerometer data.
    FlutterEventChannel* accelerometerChannel =
    [FlutterEventChannel eventChannelWithName:@"fazi.com/accelerometer_sensor/accelerometer"
                              binaryMessenger:[registrar messenger]];
    
    // Set the stream handler to handle accelerometer events.
    [accelerometerChannel setStreamHandler:accelerometerStreamHandler];
}

@end

/**
 * Constant representing gravity acceleration in meters per second squared.
 */
const double GRAVITY_VAL = 9.8;

/**
 * Motion manager instance used to access accelerometer data.
 */
CMMotionManager* _cmMotionManager;

/**
 * Initializes the Core Motion manager if it has not been created.
 */
void _initCMMotionManager() {
    if (!_cmMotionManager) {
        _cmMotionManager = [[CMMotionManager alloc] init];
    }
}

/**
 * Sends accelerometer data as a triplet (x, y, z) to Flutter.
 *
 * @param x Acceleration value along the x-axis.
 * @param y Acceleration value along the y-axis.
 * @param z Acceleration value along the z-axis.
 * @param sink The FlutterEventSink to send the accelerometer data.
 */
static void sendTriplet(Float64 x, Float64 y, Float64 z, FlutterEventSink sink) {
    NSMutableData* event = [NSMutableData dataWithCapacity:3 * sizeof(Float64)];
    [event appendBytes:&x length:sizeof(Float64)];
    [event appendBytes:&y length:sizeof(Float64)];
    [event appendBytes:&z length:sizeof(Float64)];
    
    // Send the accelerometer data to Flutter as a Float64 typed data.
    sink([FlutterStandardTypedData typedDataWithFloat64:event]);
}

@implementation CDYAccelerometerStreamHandler

/**
 * Starts listening for accelerometer data and sends it to Flutter.
 *
 * @param arguments Any arguments passed from Flutter (not used in this case).
 * @param eventSink The FlutterEventSink that will receive accelerometer data updates.
 * @return A FlutterError if the accelerometer is unavailable, otherwise nil.
 */
- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    // Initialize the motion manager if needed.
    _initCMMotionManager();
    
    // Check if the accelerometer is available on the device.
    if (!_cmMotionManager.isAccelerometerAvailable) {
        return [FlutterError errorWithCode:@"ACCELEROMETER_UNAVAILABLE"
                                   message:@"Accelerometer is not available on this device"
                                   details:nil];
    }

    // Set the accelerometer update interval to 100ms.
    _cmMotionManager.accelerometerUpdateInterval = 0.1;
    
    // Start receiving accelerometer updates.
    [_cmMotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                           withHandler:^(CMAccelerometerData* data, NSError* error) {
        if (error) {
            // If an error occurs, send it back to Flutter.
            eventSink([FlutterError errorWithCode:@"ACCELEROMETER_ERROR"
                                          message:error.localizedDescription
                                          details:nil]);
            return;
        }
        
        // If accelerometer data is available, send it to Flutter.
        if (data) {
            CMAcceleration acceleration = data.acceleration;
            sendTriplet(acceleration.x * GRAVITY_VAL, 
                        acceleration.y * GRAVITY_VAL, 
                        acceleration.z * GRAVITY_VAL, eventSink);
        }
    }];
    
    return nil;
}

/**
 * Stops listening for accelerometer data.
 *
 * @param arguments Any arguments passed from Flutter (not used in this case).
 * @return Always returns nil as there is no error in stopping the sensor.
 */
- (FlutterError*)onCancelWithArguments:(id)arguments {
    [_cmMotionManager stopAccelerometerUpdates];
    return nil;
}

@end
