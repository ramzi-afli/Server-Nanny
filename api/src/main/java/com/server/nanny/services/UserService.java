package com.server.nanny.services;

import com.server.nanny.exceptions.RackNotFoundException;
import com.server.nanny.exceptions.RoomNotFoundException;
import com.server.nanny.exceptions.UserAlreadyExistsException;
import com.server.nanny.exceptions.UserNotFoundException;
import com.server.nanny.models.Rack;
import com.server.nanny.models.Room;
import com.server.nanny.models.Sensor;
import com.server.nanny.models.User;

import java.sql.DataTruncation;
import java.util.List;
import java.util.Set;

public interface UserService {

    User createUser(User user) throws UserAlreadyExistsException;
    User addUser(User user) throws  UserAlreadyExistsException  ;
    void delete(String email) throws  UserNotFoundException ;
    void assignRoomToUser(String email  , String roomId) throws  UserNotFoundException, RoomNotFoundException ;
    Set<Room> findAssignedRoom(String  email ) throws  UserNotFoundException  ;
    List<Rack> findRacksInsideRoom(String  roomId) throws  RoomNotFoundException ;

    List<Sensor> findSensorsValuesByRackId(String rackId) throws RackNotFoundException;
    Set<Room> findAllRoom() ;
}
