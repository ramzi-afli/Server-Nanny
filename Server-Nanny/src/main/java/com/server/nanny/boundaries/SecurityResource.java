package com.server.nanny.boundaries;


import com.server.nanny.models.Role;
import com.server.nanny.models.User;
import com.server.nanny.security.SecurityService;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("security")

@Consumes(MediaType.APPLICATION_JSON)

@Produces(MediaType.APPLICATION_JSON)

public class SecurityResource {

    @Inject
    private SecurityService securityService ;



    @POST
    public void create(@Valid User user) {
        securityService.create(user);

    }

    @DELETE
    @Path("{id}")
    @RolesAllowed("ADMIN")
    public void delete(@PathParam("id") int id) {
        securityService.delete(id);

    }

    @Path("{id}")
    @PUT
    public void changePassword(@PathParam("id") int id, @Valid User user) {
        securityService.updatePassword(id, user);

    }

    @Path("roles/{id}")
    @PUT
    @RolesAllowed("ADMIN")
    public void addRole(@PathParam("id") int id, Role role){
        securityService.addRole(id, role);

    }
    @Path("roles/{id}")
    @DELETE
    @RolesAllowed("ADMIN")

    public void removeRole(@PathParam("id") int id, Role role){

        securityService.removeRole(id, role);

    }


    @Path("me")
    @GET
    public User getMe() {
        return securityService.getUser();

    }


    @Path("users")
    @GET
    @RolesAllowed("ADMIN")

    public List<User> getUsers() {
        return securityService.getUsers();

    }

}

