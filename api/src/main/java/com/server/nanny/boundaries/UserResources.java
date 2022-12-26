package com.server.nanny.boundaries;


import com.server.nanny.exceptions.*;
import com.server.nanny.filters.Secured;
import com.server.nanny.models.User;
import com.server.nanny.services.UserServiceImpl;

import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@ApplicationScoped
@Path("")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserResources {

    @Inject
    private UserServiceImpl userService ;


    /**
     *
     * @param user
     * @return Response entity
     * @throws  UserAlreadyExistsException
     * @throws  UserNotAuthorizedToCreateAccountException
     * @apiNote : used to  create admin account
     */

    @POST
    @Path("/signup")
    public Response createUser(@Valid User user){
         try {
             return Response.ok(userService.createUser(user)).build() ;
         } catch (UserAlreadyExistsException  e){
             return  Response.status(400, e.getMessage()).build();
         }catch (UserNotAuthorizedToCreateAccountException exception){
             return  Response.status(400  ,exception.getMessage()).build();
         }


    }

    /**
     *
     * @param user
     * @return status
     * @throws  UserAlreadyExistsException
     * @apiNote  this methode is used by the admin to add users
     */

    @POST()
    @Path("user/add")
    @Secured
    @RolesAllowed("ADMIN")
    public  Response addUser( @Valid User user){
        try {
            var createdUser = userService.addUser(user);
            return Response.ok(createdUser.getForname() +" "+ createdUser.getSurname() + " is added successfully ").build();
        } catch(UserAlreadyExistsException e) {
            return Response.status(400 , e.getMessage()).build() ;

        }

    }


    /**
     *
     * @param email
     * @return status
     * @throws  UserNotFoundException
     * @apiNote  this  methode is used by the Admin to delete users
     */


    @DELETE()
    @Path("user/{email}")
    @RolesAllowed("ADMIN")
    public  Response deleteUser(@PathParam("email") String email){
        try {
              userService.delete(email);
              return  Response.ok().build() ;
        }catch(UserNotFoundException e){
            return  Response.status(400 , e.getMessage()).build() ;
        }

    }



    @PUT
    @Path("user/{email}/room/{roomId}")
    @RolesAllowed({"ADMIN"})
    public  Response assignUserToRoom(@PathParam("email") String email ,
                                      @PathParam("roomId") String roomId){

        try{
            userService.assignRoomToUser(email,roomId);
            return  Response.ok().build();
        }catch (UserNotFoundException userNotFoundException){
            return  Response.status(400 ,userNotFoundException.getMessage()).build();
        }catch (RoomNotFoundException roomNotFoundException){
            return  Response.status(400 ,roomNotFoundException.getMessage()).build();
        }

    }


    @GET
    @Path(("/user/room/{email}"))
    @RolesAllowed({"ADMIN","USER"})
    public  Response findAssignedRoom(@PathParam(("email")) String email){
            try{
                return Response.ok(userService.findAssignedRoom(email)).build();
            }catch (UserNotFoundException exception){
                return  Response.status(400,exception.getMessage()).build();
            }
    }

    @GET
    @Path(("/user/rack/{roomId}"))
    @RolesAllowed({"ADMIN","USER"})
    public  Response getRacksInsideRoom(@PathParam(("roomId")) String roomId){
        try {
            return  Response.ok(userService.findRacksInsideRoom(roomId)).build() ;
        }catch (RoomNotFoundException roomNotFoundException){
            return  Response.status(400, roomNotFoundException.getMessage()).build() ;
        }

    }



    @GET
    @Path(("/user/sensor/{rackid}"))
    @RolesAllowed({"ADMIN","USER"})
    public Response getSensorsValues(@PathParam(("rackid")) String rack ){
         try{
             return  Response.ok(userService.findSensorsValuesByRackId(rack)).build();
         }catch (RackNotFoundException e){
             return  Response.status(400,e.getMessage()).build();
         }
    }

    @GET
    @Path("/user/room")
    @RolesAllowed("ADMIN")

    public  Response getAllRooms(){
        return Response.ok(userService.findAllRoom()).build() ;
    }












}
