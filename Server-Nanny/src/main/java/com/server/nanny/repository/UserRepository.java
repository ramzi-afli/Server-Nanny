package com.server.nanny.repository;


import com.server.nanny.models.User;
import jakarta.nosql.mapping.Repository;

public interface UserRepository extends Repository<User ,Integer> {
}
