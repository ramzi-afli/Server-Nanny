package com.server.nanny.services;


import com.server.nanny.models.User;
import com.server.nanny.repository.UserRepository;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ApplicationScoped
public class UserServiceImpl  implements  UserService{

    @Inject
    private UserRepository userRepository;
    Integer  counter=1 ;
    public User createUser(User user){


        user.setId(this.counter);
        this.counter ++ ;
         return  userRepository.save(user) ;
    }

public User  findUserById(Integer id ){

        return  userRepository.findById(id).get() ;
}


}
