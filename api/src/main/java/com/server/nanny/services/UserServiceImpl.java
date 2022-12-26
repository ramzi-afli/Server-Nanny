package com.server.nanny.services;


import com.server.nanny.exceptions.*;
import com.server.nanny.models.*;
import com.server.nanny.repository.RackRepository;
import com.server.nanny.repository.RoomRepository;
import com.server.nanny.repository.SensorRepository;
import com.server.nanny.repository.UserRepository;
import com.server.nanny.util.Argon2Utility;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Set;

@ApplicationScoped
public class UserServiceImpl  implements  UserService{

    @Inject
    private UserRepository userRepository;
    @Inject
    private RoomRepository roomRepository ;
    @Inject
    private RackRepository rackRepository ;
    @Inject
    private SensorRepository sensorRepository ;

    @Inject
    Argon2Utility argon2Utility ;




    /**
     *
     * @param user
     * @return User
     * @apiNote  THis methode  is used  to create Admin account
     */

    public User createUser(User user){
        if( user.getRoles().contains(Role.USER)){
            throw new UserNotAuthorizedToCreateAccountException("Only the  admin can create users accounts") ;
        }
        if(userRepository.findById(user.getEmail()).isPresent()){
            throw  new UserAlreadyExistsException(user.getEmail()+" is already exists") ;
        }
        user.updatePassword(user.getPassword(),argon2Utility);
        return  userRepository.save(user) ;
    }





    /**
     *
     * @param user
     * @return User
     * @throws UserAlreadyExistsException
     * @apiNote  This methode is  used   when the admin add some users to maintain  racks
     */
    @Override
    public User addUser(User user)  {
         if(userRepository.findById(user.getEmail()).isPresent()){
             throw new UserAlreadyExistsException(user.getEmail() +" already exists") ;
         }
         user.updatePassword(user.getPassword(),argon2Utility);
         return userRepository.save(user) ;

    }

    /**
     *
     * @param email
     * @throws  UserNotFoundException
     * @apiNote this methode used by the admin to delete users
     */

    @Override
    public void delete(String email)  {
        if(!userRepository.findById(email).isPresent()){
            throw new UserNotFoundException("there is  no user with email :"+email) ;
        }
        userRepository.deleteById(email);

    }



    @Override
    @Transactional
    public void assignRoomToUser(String email, String roomId) {
        if(!userRepository.findById(email).isPresent()){
            throw new UserNotFoundException("no user with  email= "+email);
        }
        if(!roomRepository.findById(roomId).isPresent()){
                throw  new RoomNotFoundException("there is no room with id = "+roomId) ;
        }
        Room room=roomRepository.findById(roomId).get();
        room.setUserEmail(email);
        roomRepository.save(room);
        }

    @Override
    public Set<Room> findAssignedRoom(String email)  {
         if(!userRepository.findById(email).isPresent()){
             throw  new UserNotFoundException("there is no user with email = "+email) ;
         }
         return roomRepository.findByUserEmail(email);
    }

    @Override
    public List<Rack> findRacksInsideRoom(String roomId)  {
        if(!roomRepository.findById(roomId).isPresent()){
            throw  new RoomNotFoundException("there is no room with id = "+roomId) ;
        }
        System.out.println(rackRepository.findByRoomId(roomId));
        return rackRepository.findByRoomId(roomId);
    }

    @Override
    public List<Sensor> findSensorsValuesByRackId(String rackId) throws RackNotFoundException {
          if(!rackRepository.findById(rackId).isPresent()){
              throw  new RackNotFoundException("there is  no rack with such id : "+rackId) ;
          }
          return  sensorRepository.findByRack(rackId);

    }

    @Override
    public Set<Room> findAllRoom() {
        return  roomRepository.findAll()  ;
    }
}

