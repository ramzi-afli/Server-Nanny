package com.server.nanny.services;

import com.server.nanny.models.Rack;
import com.server.nanny.models.Room;
import com.server.nanny.repository.RoomRepository;

import javax.inject.Inject;
import java.util.Set;

public class RoomServiceImp {

    @Inject
    private RoomRepository roomRepository ;


    public Room createRoom( Room room){
        System.out.println(room.getRacks());
        return  roomRepository.save(room);

    }
    public Set<Room> getALlRooms(){
        return  roomRepository.findAll()  ;
    }
}
