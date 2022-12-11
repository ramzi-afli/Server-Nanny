package com.server.nanny.security;


import com.server.nanny.exceptions.UserNotAuthorizedException;
import com.server.nanny.models.User;
import com.server.nanny.repository.UserTokenRepository;


import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@ApplicationScoped
public class Oauth2Service {


    static final int EXPIRE_IN = 3600;
    static final Duration EXPIRES = Duration.ofSeconds(EXPIRE_IN);
    @Inject
    private UserTokenRepository userTokenRepository ;

    @Inject
    private SecurityService securityService;

    @Inject
    private Validator validator;




    public  Map<String, Object> token(Oauth2Request request) {

        final User user = securityService.findBy(request.getEmail(), request.getPassword());

        final UserToken userToken = userTokenRepository.findByEmail(request.getEmail())
                .orElse(new UserToken(user.getEmail()));

        System.out.println("is token here   3 print ");
        final com.server.nanny.security.Token token= com.server.nanny.security.Token.generate() ;
        final String jwt = UserJWT.createToken(user, token, EXPIRES);
        System.out.println("is token here   4 print ");
        AccessToken accessToken = new AccessToken(token.get(), jwt, EXPIRES);
        RefreshToken refreshToken = userToken.update(accessToken, request.getRefreshToken(),userTokenRepository);
        System.out.println("is token here   5 print ");
        HashMap<String, Object> map = new HashMap<>();
        map.put("accessToken", accessToken.getToken());
        map.put("refreshToken", refreshToken.getToken());


       // final Oauth2Response response = Oauth2Response.of(accessToken, refreshToken, EXPIRE_IN);
        return map;
    }





    public Map<String, Object> refreshToken(Oauth2Request request) {
        final Set<ConstraintViolation<Oauth2Request>> violations = validator.validate(request, Oauth2Request
                .RefreshToken.class);

        if (!violations.isEmpty()) {
            throw new ConstraintViolationException(violations);
        }
        final UserToken userToken = userTokenRepository.findByRefreshToken(request.getRefreshToken())
                .orElseThrow(() -> new UserNotAuthorizedException());
        final User user = securityService.findBy(userToken.getEmail());
        final Token token = Token.generate();
        final String jwt = UserJWT.createToken(user, token, EXPIRES);
        AccessToken accessToken = new AccessToken(token.get(), jwt, EXPIRES);
        RefreshToken refreshToken = userToken.update(accessToken, request.getRefreshToken(), userTokenRepository);
        HashMap<String, Object> map = new HashMap<>();
        map.put("accessToken", accessToken.getToken());
        map.put("refreshToken", refreshToken.getToken());
        return map;
    }



}
