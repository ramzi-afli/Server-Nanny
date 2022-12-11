package com.server.nanny.services;

import com.server.nanny.exceptions.UserAlreadyExistsException;
import com.server.nanny.exceptions.UserNotFoundException;
import com.server.nanny.models.User;

public interface UserService {

    User createUser(User user) throws UserAlreadyExistsException;
    User  findUserById(Integer id) throws UserNotFoundException ;

}
