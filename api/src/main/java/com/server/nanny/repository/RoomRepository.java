package com.server.nanny.repository;


import com.server.nanny.models.Rack;
import com.server.nanny.models.Room;
import jakarta.nosql.mapping.Repository;

import java.util.Set;

public interface RoomRepository extends Repository<Room,String> {


    Set<Room> findAll()  ;
    Set<Room> findByUserEmail(String email) ;
}
