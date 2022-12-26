package com.server.nanny.models;

import com.server.nanny.util.FieldPropertyVisibilityStrategy;
import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import javax.json.bind.annotation.JsonbVisibility;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Sensor {



    @Id
    private  String id ;

    @Column("rack")
    private  String rack ;
    @Column("altitude")
    private  double  altitude ;
    @Column("longitude")
    private  double longitude  ;
    @Column("sensor_type")
    private  SensorType type ;
    @Column("value")
    private Set<Double> values=new HashSet<>() ;


    public Set<Double> getValues() {
        return values;
    }

    public void setValues(Set<Double> values) {
        this.values = values;
    }

    public Sensor(String id, String rack, SensorType type, Set<Double> values) {
        this.id = id;
        this.rack = rack;
        this.type = type;
        this.values = values;
    }

    /**
     * ALL ARGS CONSTRUCTOR && NO ARGS CONSTRUCTOR
     */


    public Sensor() {
    }

    /**
     *
     * ALl GETTERS
     */
    public String getId() {
        return id;
    }


    public String getRack() {
        return rack;
    }

    public void setRack(String rack) {
        this.rack = rack;
    }



    public SensorType getType() {
        return type;
    }

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    /**
     *
     * ALL SETTERS
     */
    public void setId(String id) {
        this.id = id;
    }



    public void setType(SensorType type) {
        this.type = type;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Sensor sensor = (Sensor) o;
        return Double.compare(sensor.altitude, altitude) == 0 && Double.compare(sensor.longitude, longitude) == 0 && Objects.equals(id, sensor.id) && type == sensor.type;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, altitude, longitude, type);
    }

    @Override
    public String toString() {
        return "Sensor{" +
                "id='" + id + '\'' +
                ", altitude=" + altitude +
                ", longitude=" + longitude +
                ", type=" + type +
                '}';
    }
}
