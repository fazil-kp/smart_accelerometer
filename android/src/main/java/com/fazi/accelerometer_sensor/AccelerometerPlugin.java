package com.fazi.accelerometer_sensor;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

/**
 * Flutter plugin for accessing the accelerometer sensor in an Android device.
 * This plugin sets up an event channel to stream accelerometer data to a Flutter application.
 */
public class AccelerometerPlugin implements FlutterPlugin {

    /**
     * Name of the event channel used for streaming accelerometer data.
     */
    private static final String ACCELEROMETER_CHANNEL_NAME = "fazi.com/accelerometer_sensor/accelerometer";
    
    /**
     * Event channel to communicate accelerometer data between the Android native layer and Flutter.
     */
    private EventChannel accelerometerChannel;

    /**
     * Sets up the event channels for streaming sensor data.
     *
     * @param context   The application context.
     * @param messenger The binary messenger for communicating with Flutter.
     */
    private void setupEventChannels(Context context, BinaryMessenger messenger) {
        // Obtain the sensor manager to access device sensors.
        SensorManager sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        
        // Check if the sensor manager is available.
        if (sensorManager != null) {
            // Create the event channel for accelerometer data.
            accelerometerChannel = new EventChannel(messenger, ACCELEROMETER_CHANNEL_NAME);
            
            // Set a stream handler that will manage accelerometer data.
            accelerometerChannel.setStreamHandler(new StreamHandlerImpl(sensorManager, Sensor.TYPE_ACCELEROMETER));
        }
    }

    /**
     * Called when the Flutter plugin is attached to the engine.
     * This method initializes the event channels for accelerometer data.
     *
     * @param binding The Flutter plugin binding that provides application context and binary messenger.
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        setupEventChannels(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    /**
     * Called when the Flutter plugin is detached from the engine.
     * This method cleans up the event channel to prevent memory leaks.
     *
     * @param binding The Flutter plugin binding that was used to attach the plugin.
     */
    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (accelerometerChannel != null) {
            // Remove the stream handler to clean up resources.
            accelerometerChannel.setStreamHandler(null);
        }
    }
}