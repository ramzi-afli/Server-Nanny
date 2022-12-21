package com.server.nanny.repository;

import com.server.nanny.models.Sensor;
import jakarta.nosql.mapping.Repository;

import java.util.List;

public interface SensorRepository extends Repository<Sensor, String> {


    List<Sensor> findByRack(String rack) ;
}
