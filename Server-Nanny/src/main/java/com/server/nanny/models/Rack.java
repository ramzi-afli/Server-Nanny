package com.server.nanny.models;


import javax.json.bind.annotation.JsonbVisibility;

import com.server.nanny.util.FieldPropertyVisibilityStrategy;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;
import java.util.Objects;


@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Rack {

    @Id
    private  Integer id ;

    public Rack() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
