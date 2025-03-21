package com.fazi.accelerometer_sensor;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

import io.flutter.plugin.common.EventChannel;

public class StreamHandlerImpl implements EventChannel.StreamHandler {

    private final SensorManager sensorManager;
    private final Sensor sensor;
    private SensorEventListener sensorEventListener;

    public StreamHandlerImpl(SensorManager sensorManager, int sensorType) {
        this.sensorManager = sensorManager;
        this.sensor = sensorManager.getDefaultSensor(sensorType);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        if (sensor == null) {
            events.error("SENSOR_UNAVAILABLE", "Accelerometer sensor not available", null);
            return;
        }

        sensorEventListener = new SensorEventListener() {
            @Override
            public void onSensorChanged(SensorEvent event) {
                double[] sensorValues = new double[event.values.length];
                for (int i = 0; i < event.values.length; i++) {
                    sensorValues[i] = event.values[i];
                }
                events.success(sensorValues);
            }

            @Override
            public void onAccuracyChanged(Sensor sensor, int accuracy) {}
        };

        sensorManager.registerListener(sensorEventListener, sensor, SensorManager.SENSOR_DELAY_UI);
    }

    @Override
    public void onCancel(Object arguments) {
        if (sensorEventListener != null) {
            sensorManager.unregisterListener(sensorEventListener);
        }
    }
}
