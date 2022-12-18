package com.server.nanny.services;

import com.server.nanny.exceptions.UserAlreadyExistsException;
import com.server.nanny.exceptions.UserNotFoundException;
import com.server.nanny.models.User;

import java.sql.DataTruncation;

public interface UserService {

    User createUser(User user) throws UserAlreadyExistsException;
    User addUser(User user) throws  UserAlreadyExistsException  ;
    void delete(String email) throws  UserNotFoundException ;

}
