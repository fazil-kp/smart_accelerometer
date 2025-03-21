#import <Foundation/Foundation.h>
#import "AccelerometerPlugin.h"
#import <CoreMotion/CoreMotion.h>

@implementation AccelerometerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    CDYAccelerometerStreamHandler* accelerometerStreamHandler = [[CDYAccelerometerStreamHandler alloc] init];
    FlutterEventChannel* accelerometerChannel =
    [FlutterEventChannel eventChannelWithName:@"fazi.com/accelerometer_sensor/accelerometer"
                              binaryMessenger:[registrar messenger]];
    [accelerometerChannel setStreamHandler:accelerometerStreamHandler];
}

@end

const double GRAVITY_VAL = 9.8;
CMMotionManager* _cmMotionManager;

void _initCMMotionManager() {
    if (!_cmMotionManager) {
        _cmMotionManager = [[CMMotionManager alloc] init];
    }
}

static void sendTriplet(Float64 x, Float64 y, Float64 z, FlutterEventSink sink) {
    NSMutableData* event = [NSMutableData dataWithCapacity:3 * sizeof(Float64)];
    [event appendBytes:&x length:sizeof(Float64)];
    [event appendBytes:&y length:sizeof(Float64)];
    [event appendBytes:&z length:sizeof(Float64)];
    sink([FlutterStandardTypedData typedDataWithFloat64:event]);
}

@implementation CDYAccelerometerStreamHandler

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    _initCMMotionManager();
    
    if (!_cmMotionManager.isAccelerometerAvailable) {
        return [FlutterError errorWithCode:@"ACCELEROMETER_UNAVAILABLE"
                                   message:@"Accelerometer is not available on this device"
                                   details:nil];
    }

    _cmMotionManager.accelerometerUpdateInterval = 0.1; // 100ms interval
    [_cmMotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                           withHandler:^(CMAccelerometerData* data, NSError* error) {
        if (error) {
            eventSink([FlutterError errorWithCode:@"ACCELEROMETER_ERROR"
                                          message:error.localizedDescription
                                          details:nil]);
            return;
        }
        if (data) {
            CMAcceleration acceleration = data.acceleration;
            sendTriplet(acceleration.x * GRAVITY_VAL, 
                        acceleration.y * GRAVITY_VAL, 
                        acceleration.z * GRAVITY_VAL, eventSink);
        }
    }];
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    [_cmMotionManager stopAccelerometerUpdates];
    return nil;
}

@end
