package com.server.nanny.models;

import com.server.nanny.util.FieldPropertyVisibilityStrategy;
import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import javax.json.bind.annotation.JsonbVisibility;
import java.util.Objects;


@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Sensor {



    @Id
    private  Integer id ;

    @Column("position")
    private  String  position ;

    @Column("sensor_type")
    private  SensorType type ;


    /**
     * ALL ARGS CONSTRUCTOR && NO ARGS CONSTRUCTOR
     */
    public Sensor(String position, SensorType type) {
        this.position = position;
        this.type = type;
    }

    public Sensor() {
    }

    /**
     *
     * ALl GETTERS
     */
    public Integer getId() {
        return id;
    }

    public String getPosition() {
        return position;
    }

    public SensorType getType() {
        return type;
    }


    /**
     *
     * ALL SETTERS
     */
    public void setId(Integer id) {
        this.id = id;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public void setType(SensorType type) {
        this.type = type;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Sensor sensor = (Sensor) o;
        return id.equals(sensor.id) && position.equals(sensor.position) && type == sensor.type;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, position, type);
    }

    @Override
    public String toString() {
        return "{" +
                "id=" + id +
                ", position='" + position + '\'' +
                ", type=" + type +
                '}';
    }
}
