package com.fazi.accelerometer_sensor;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

import io.flutter.plugin.common.EventChannel;

/**
 * StreamHandlerImpl is responsible for handling the accelerometer sensor data stream.
 * It listens to sensor changes and sends data to Flutter via an EventChannel.
 */
public class StreamHandlerImpl implements EventChannel.StreamHandler {

    /**
     * SensorManager instance to manage device sensors.
     */
    private final SensorManager sensorManager;
    
    /**
     * Reference to the accelerometer sensor.
     */
    private final Sensor sensor;
    
    /**
     * Listener for sensor events.
     */
    private SensorEventListener sensorEventListener;

    /**
     * Constructor to initialize the StreamHandlerImpl with a sensor manager and sensor type.
     *
     * @param sensorManager The SensorManager used to access device sensors.
     * @param sensorType    The type of sensor to listen for (e.g., accelerometer).
     */
    public StreamHandlerImpl(SensorManager sensorManager, int sensorType) {
        this.sensorManager = sensorManager;
        this.sensor = sensorManager.getDefaultSensor(sensorType);
    }

    /**
     * Called when the Flutter side starts listening for sensor data.
     * Registers a listener to stream sensor data to Flutter.
     *
     * @param arguments Additional arguments (not used in this implementation).
     * @param events    The EventSink to send sensor data to Flutter.
     */
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        // Check if the accelerometer sensor is available
        if (sensor == null) {
            events.error("SENSOR_UNAVAILABLE", "Accelerometer sensor not available", null);
            return;
        }

        // Define a sensor event listener to handle sensor data changes
        sensorEventListener = new SensorEventListener() {
            @Override
            public void onSensorChanged(SensorEvent event) {
                // Convert float sensor values to double array
                double[] sensorValues = new double[event.values.length];
                for (int i = 0; i < event.values.length; i++) {
                    sensorValues[i] = event.values[i];
                }
                // Send sensor data to Flutter
                events.success(sensorValues);
            }

            @Override
            public void onAccuracyChanged(Sensor sensor, int accuracy) {
                // No action needed for accuracy changes
            }
        };

        // Register the sensor event listener with UI delay for balanced performance
        sensorManager.registerListener(sensorEventListener, sensor, SensorManager.SENSOR_DELAY_UI);
    }

    /**
     * Called when the Flutter side stops listening for sensor data.
     * Unregistered the sensor event listener to free resources.
     *
     * @param arguments Additional arguments (not used in this implementation).
     */
    @Override
    public void onCancel(Object arguments) {
        if (sensorEventListener != null) {
            sensorManager.unregisterListener(sensorEventListener);
        }
    }
}
