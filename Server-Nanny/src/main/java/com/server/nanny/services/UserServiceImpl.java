package com.server.nanny.services;


import com.server.nanny.exceptions.UserAlreadyExistsException;
import com.server.nanny.models.User;
import com.server.nanny.repository.UserRepository;
import com.server.nanny.util.Argon2Utility;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ApplicationScoped
public class UserServiceImpl  implements  UserService{

    @Inject
    private UserRepository userRepository;
    @Inject
    Argon2Utility argon2Utility ;
    public User createUser(User user){
        if(userRepository.findById(user.getEmail()).isPresent()){
            throw  new UserAlreadyExistsException(user.getEmail()+" is already exists") ;
        }
          user.updatePassword(user.getPassword(),argon2Utility);
         return  userRepository.save(user) ;
    }

public User  findUserById(String email ){
        return  userRepository.findById(email).get() ;
}


}
