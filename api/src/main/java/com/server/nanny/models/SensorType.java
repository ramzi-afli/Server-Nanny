package com.server.nanny.models;

import java.util.function.Supplier;

public enum SensorType implements Supplier<String> {
    TEMPERATURE_SENSOR ,
    CAMERA,
    HUMIDITY_SENSOR;
    @Override
    public String get() {
        return this.name();
    }
}
