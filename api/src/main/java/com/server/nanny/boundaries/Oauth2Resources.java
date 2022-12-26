package com.server.nanny.boundaries;


import com.server.nanny.security.Oauth2Request;
import com.server.nanny.security.Oauth2Response;
import com.server.nanny.security.Oauth2Service;


import javax.annotation.security.PermitAll;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import static com.server.nanny.security.GrantType.PASSWORD;
import static com.server.nanny.security.GrantType.REFRESH_TOKEN;


@ApplicationScoped
@Path("oauth2")
public class Oauth2Resources {

    @Inject
    private Oauth2Service service;


    @POST
    @Path("token")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)

    public Oauth2Response token(  Oauth2Request request) {
        switch (request.getGrandType()) {

            case PASSWORD:
                return service.token(request);
            case REFRESH_TOKEN:
                return service.refreshToken(request);
            default:
                throw new UnsupportedOperationException("There is not support to another type");
        }
    }
}