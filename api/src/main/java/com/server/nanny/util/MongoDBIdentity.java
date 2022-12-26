package com.server.nanny.util;

import com.server.nanny.models.User;
import com.server.nanny.repository.UserRepository;

import javax.inject.Inject;
import javax.security.enterprise.credential.Credential;
import javax.security.enterprise.credential.Password;
import javax.security.enterprise.credential.UsernamePasswordCredential;
import javax.security.enterprise.identitystore.CredentialValidationResult;
import javax.security.enterprise.identitystore.IdentityStore;
import java.util.*;

import static javax.security.enterprise.identitystore.CredentialValidationResult.INVALID_RESULT;

public class MongoDBIdentity implements IdentityStore {
    @Inject
    private UserRepository repository;

    @Inject
    private Argon2Utility argon2Utility ;

    @Override
    public int priority() {
        return 10;
    }

    @Override
    public CredentialValidationResult validate(Credential credential) {

        if (credential instanceof UsernamePasswordCredential) {
            UsernamePasswordCredential userCredential = UsernamePasswordCredential
                    .class.cast(credential);
            //password coming from the login request
            final Password userPassword = userCredential.getPassword();

            final Optional<User> userOptional = repository.findByEmail(userCredential.getCaller());

            if (userOptional.isPresent()) {

                final User user = userOptional.get();

                   String   hashedUserPassword=argon2Utility.hash(userPassword.getValue()) ;
                if (argon2Utility.check(hashedUserPassword, user.getPassword().toCharArray())) {
                   Set<String> roles = new HashSet<>() ;

                    user.getRoles().forEach(role ->
                           roles.add(role.toString()) );
                    return new CredentialValidationResult(user.getEmail(), roles);
                }
            }

        }

        return INVALID_RESULT;

    }

}



