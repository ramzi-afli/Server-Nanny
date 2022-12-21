package com.server.nanny.exceptions;

public class RackNotFoundException extends RuntimeException{
    String message ;
    public  RackNotFoundException(String msg){
        super(msg);
        this.message=msg ;
    }
}
