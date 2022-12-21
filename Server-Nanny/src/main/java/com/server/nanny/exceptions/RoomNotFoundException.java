package com.server.nanny.exceptions;

public class RoomNotFoundException  extends  RuntimeException{
    String  message ;
    public  RoomNotFoundException(String msg){
        super(msg);
        this.message=msg;
    }

}
