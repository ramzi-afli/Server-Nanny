package com.server.nanny.boundaries;


import com.server.nanny.models.User;
import com.server.nanny.services.UserServiceImpl;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@ApplicationScoped
@Path("user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController  {


    @Inject
    private UserServiceImpl userService ;


    @POST
    public Response createUser(User user){
        return Response.ok(userService.createUser(user).toString()).build() ;
    }

    @GET
    @Path("{id}")
    public Response getUserById(@PathParam("id") Integer id){
        return Response.ok(userService.findUserById(id)).build() ;
    }

}
