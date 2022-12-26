package com.server.nanny.repository;

import com.server.nanny.models.Rack;
import com.server.nanny.security.UserToken;
import jakarta.mail.search.SearchTerm;
import jakarta.nosql.mapping.Param;
import jakarta.nosql.mapping.Query;
import jakarta.nosql.mapping.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface RackRepository  extends Repository<Rack,String> {


    List<Rack> findByRoomId(String roomId);

}
