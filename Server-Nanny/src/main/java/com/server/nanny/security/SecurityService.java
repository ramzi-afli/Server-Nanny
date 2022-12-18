package com.server.nanny.security;


import com.server.nanny.exceptions.UserAlreadyExistsException;
import com.server.nanny.exceptions.UserForbiddenException;
import com.server.nanny.exceptions.UserNotAuthorizedException;
import com.server.nanny.exceptions.UserNotFoundException;
import com.server.nanny.models.Role;
import com.server.nanny.models.User;
import com.server.nanny.repository.UserRepository;
import com.server.nanny.repository.UserTokenRepository;
import com.server.nanny.util.Argon2Utility;
import jakarta.nosql.mapping.Database;
import jakarta.nosql.mapping.DatabaseType;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;
import java.security.Principal;
import java.util.List;
import java.util.Set;

@ApplicationScoped
public class SecurityService {

    @Inject
    private UserRepository userRepository;

    @Inject
    private Argon2Utility argon2Utility ;

    @Inject
    private SecurityContext securityContext;

     public void create(User user) {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new UserAlreadyExistsException("There is user with email  " + user.getEmail());
        } else {
            // we must hash the  password  before saving it
            user.updatePassword(user.getPassword(), argon2Utility);
            userRepository.save(user);
        }
    }


     public    void delete(String email ) {
            userRepository.deleteById(email);

        }



   public void updatePassword(String email, User dto) {
        final Principal principal = securityContext.getCallerPrincipal();
        if (isForbidden(email, securityContext, principal)) {
            throw new UserForbiddenException();
        }
        final User user = userRepository.findById(email)
                .orElseThrow(() -> new UserNotFoundException(email));
        user.updatePassword(dto.getPassword(), argon2Utility);
        userRepository.save(user);

    }

    /**
     * @apiNote  used to roles  to user
     * @param email  : user  email
     * @param role : role to  add
     *
     */
    public void addRole(String email, Role role
    ) {

        final User user = userRepository.findById(email)
                .orElseThrow(() -> new UserNotFoundException(email));

        Set<Role> roles=user.getRoles() ;
        roles.add(role) ;
        user.setRoles(roles);
        userRepository.save(user);
    }


    /**
     * @apiNote  used to delete  roles to user
     * @param email
     * @param role
     */

    public void removeRole(String  email , Role role) {
        final User user = userRepository.findById(email)

                .orElseThrow(() -> new UserNotFoundException(email));

        Set<Role> roles=user.getRoles() ;
        roles.remove(role) ;
        user.setRoles(roles);
        userRepository.save(user);

    }

    public User getUser() {
        final Principal principal = securityContext.getCallerPrincipal();
        if (principal == null) {
            throw new UserNotAuthorizedException();
        }
        final User user = userRepository.findById(principal.getName())
                .orElseThrow(() -> new UserNotFoundException(principal.getName()));
        return user;
    }

    public List<User> getUsers() {
        return userRepository.findAll() ;

    }

    /**
     *
     * @param email
     * @param context
     * @param principal
     * @return
     */

    private boolean isForbidden(String  email, SecurityContext context, Principal principal) {
        return !(context.isCallerInRole(Role.ADMIN.name()));

    }


    public User findBy(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotAuthorizedException());
    }




    public User findBy(String email, String password) {
        System.out.println("------------------------------------------------");
        System.out.println(userRepository.findById(email).toString());
        final User user = userRepository.findById(email)
                .orElseThrow(() -> new UserNotAuthorizedException());
        System.out.println(argon2Utility.check(user.getPassword() ,password.toCharArray()));
        if (argon2Utility.check(user.getPassword() ,password.toCharArray() )) {

            return user;
        }
        throw new UserNotAuthorizedException();

    }
}
