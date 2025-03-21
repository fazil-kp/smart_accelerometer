package com.fazi.accelerometer_sensor;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

public class AccelerometerPlugin implements FlutterPlugin {

    private static final String ACCELEROMETER_CHANNEL_NAME = "fazi.com/accelerometer_sensor/accelerometer";
    private EventChannel accelerometerChannel;

    private void setupEventChannels(Context context, BinaryMessenger messenger) {
        SensorManager sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        if (sensorManager != null) {
            accelerometerChannel = new EventChannel(messenger, ACCELEROMETER_CHANNEL_NAME);
            accelerometerChannel.setStreamHandler(new StreamHandlerImpl(sensorManager, Sensor.TYPE_ACCELEROMETER));
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        setupEventChannels(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (accelerometerChannel != null) {
            accelerometerChannel.setStreamHandler(null);
        }
    }
}
