package com.server.nanny.security;


import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import java.util.Map;

import static org.eclipse.jnosql.diana.mongodb.document.MongoDBDocumentConfigurations.PASSWORD;


@ApplicationScoped
@Path("oauth2")
public class Oauth2Resource {

    @Inject
    private Oauth2Service service;

    @POST
    @Path("token")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Map<String, Object> token(@BeanParam @Valid Oauth2Request request) {
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