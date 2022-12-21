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
public class Room {
    @Id
    private  String id ;

    @Column("assigned_user")
    private  String userEmail ;


    public Room(String id, String userEmail) {
        this.id = id;
        this.userEmail = userEmail;
    }

    public Room() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
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
