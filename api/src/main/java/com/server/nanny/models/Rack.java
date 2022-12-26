package com.server.nanny.models;


import javax.json.bind.annotation.JsonbVisibility;

import com.server.nanny.util.FieldPropertyVisibilityStrategy;
import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;
import java.util.Objects;


@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Rack {

    @Id
    private  String id ;



    @Column("room")
    private  String roomId ;

    public Rack() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Rack rack = (Rack) o;
        return Objects.equals(id, rack.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "{" +
                "id=" + id +
                '}';
    }
}
