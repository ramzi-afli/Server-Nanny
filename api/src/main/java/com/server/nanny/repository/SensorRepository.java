package com.server.nanny.repository;

import com.server.nanny.models.Sensor;
import jakarta.nosql.mapping.Repository;

import java.util.List;
import java.util.Optional;

public interface SensorRepository extends Repository<Sensor, String> {


    List<Sensor> findByRack(String rack) ;
    Optional<Sensor> findById(String id);
}
