package com.server.nanny.exceptions;

public class UserAlreadyException extends  RuntimeException{
    String message ;
    public UserAlreadyException(String msg) {
        super(msg);
        this.message=msg ;
    }

}
