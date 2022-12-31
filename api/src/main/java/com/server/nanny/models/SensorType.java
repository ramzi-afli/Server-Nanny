package com.server.nanny.models;

import java.util.function.Supplier;

public enum SensorType implements Supplier<String> {
    TEMPERATURE_SENSOR ,
    HUMIDITY_SENSOR;
    @Override
    public String get() {
        return this.name();
    }
}
