package com.server.nanny.services;

import com.server.nanny.exceptions.UserAlreadyException;
import com.server.nanny.exceptions.UserNotFoundException;
import com.server.nanny.models.User;

public interface UserService {

    User createUser(User user) throws UserAlreadyException;
    User  findUserById(Integer id) throws UserNotFoundException ;

}
