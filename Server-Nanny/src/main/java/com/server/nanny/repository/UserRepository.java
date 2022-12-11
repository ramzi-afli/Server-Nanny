package com.server.nanny.repository;


import com.server.nanny.models.User;
import jakarta.nosql.mapping.Query;
import jakarta.nosql.mapping.Repository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends Repository<User ,Integer> {

    Optional <User> findByEmail(String email ) ;
    List<User> findAll() ;

}
