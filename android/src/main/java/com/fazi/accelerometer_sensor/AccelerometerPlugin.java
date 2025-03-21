package com.fazi.accelerometer_sensor;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

/// AccelerometerPlugin 
public class AccelerometerPlugin implements FlutterPlugin {

  private static final String ACCELEROMETER_CHANNEL_NAME = "fazi.com/accelerometer_sensor/accelerometer";
  private EventChannel accelerometerChannel;

  private void setupEventChannels(Context context, BinaryMessenger messenger) {
    accelerometerChannel = new EventChannel(messenger, ACCELEROMETER_CHANNEL_NAME);
    accelerometerChannel.setStreamHandler(
            new StreamHandlerImpl((SensorManager) context.getSystemService(Context.SENSOR_SERVICE), Sensor.TYPE_ACCELEROMETER));
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    final Context context = binding.getApplicationContext();
    setupEventChannels(context, binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    accelerometerChannel.setStreamHandler(null);
  }
}