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


     public    void delete(int id ) {
            userRepository.deleteById(id);

        }



   public void updatePassword(int id, User dto) {
        final Principal principal = securityContext.getCallerPrincipal();
        if (isForbidden(id, securityContext, principal)) {
            throw new UserForbiddenException();
        }
        final User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("$id"));
        user.updatePassword(dto.getPassword(), argon2Utility);
        userRepository.save(user);

    }

    /**
     * @apiNote  used to roles  to user
     * @param id  : user  id
     * @param role : role to  add
     *
     */
    public void addRole(int id, Role role
    ) {

        final User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("$id"));

        Set<Role> roles=user.getRoles() ;
        roles.add(role) ;
        user.setRoles(roles);
        userRepository.save(user);
    }


    /**
     * @apiNote  used to delete  roles to user
     * @param id
     * @param role
     */

    public void removeRole(int id, Role role) {
        final User user = userRepository.findById(id)

                .orElseThrow(() -> new UserNotFoundException("$id"));

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
        final User user = userRepository.findById(Integer.valueOf(principal.getName()))
                .orElseThrow(() -> new UserNotFoundException(principal.getName()));
        return user;
    }

    public List<User> getUsers() {
        return userRepository.findAll() ;

    }

    /**
     *
     * @param id
     * @param context
     * @param principal
     * @return
     */

    private boolean isForbidden(int id, SecurityContext context, Principal principal) {
        return !(context.isCallerInRole(Role.ADMIN.name()));

    }


    public User findBy(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotAuthorizedException());
    }




    public User findBy(String email, String password) {
        System.out.println("--------------------in findby---------------security service");
        final User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotAuthorizedException());
        System.out.println(user.toString() +"\n");
        if (argon2Utility.check(user.getPassword() ,password.toCharArray() )) {

            return user;
        }
        throw new UserNotAuthorizedException();

    }
}
