package com.server.nanny.models;


import com.server.nanny.util.FieldPropertyVisibilityStrategy;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import javax.json.bind.annotation.JsonbVisibility;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


/**
 *room{
 *    id:1  ,
 *    racks : [
 *    rack 1 , Rack2 ,etc ..
 *    ]
 *}
 *
 */

@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Room {
    @Id
    private  Integer id ;

    private Set<Rack> racks ;

    public Set<Rack> getRacks() {
        return racks;
    }
    public void setRacks(Set<Rack> racks) {
        this.racks = racks;
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
        Room room = (Room) o;
        return Objects.equals(id, room.id);
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
