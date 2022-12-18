package com.server.nanny.boundaries;


import com.server.nanny.models.Room;
import com.server.nanny.services.RoomServiceImp;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@ApplicationScoped
@Path("room")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class RoomRessources {

    @Inject
    private RoomServiceImp roomServiceImp ;

    @POST
    public Response createRoom(Room room){
        return Response.ok(roomServiceImp.createRoom(room)).build() ;
    }

    @GET
    public Response  getAllRooms(){
        return  Response.ok(roomServiceImp.getALlRooms()).build() ;
    }

}
