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
    @Path("{email}")
    @RolesAllowed("ADMIN")
    public void delete(@PathParam("email") String email) {
        securityService.delete(email);

    }

    @Path("{email}")
    @PUT
    public void changePassword(@PathParam("email") String email, @Valid User user) {
        securityService.updatePassword(email, user);

    }

    @Path("roles/{email}")
    @PUT
    @RolesAllowed("ADMIN")
    public void addRole(@PathParam("email") String email, Role role){
        securityService.addRole(email, role);

    }
    @Path("roles/{email}")
    @DELETE
    @RolesAllowed("ADMIN")

    public void removeRole(@PathParam("email") String email, Role role){

        securityService.removeRole(email, role);

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

