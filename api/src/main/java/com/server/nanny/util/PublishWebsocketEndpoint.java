package com.server.nanny.util;

import javax.ejb.EJB;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Hashtable;

@ServerEndpoint(value = "/fire")
public class PublishWebsocketEndpoint {
    @EJB
    private MqttConnection mqttlistener;
    private static Hashtable<String, Session> sessions = new Hashtable<>(); // initialize sessions as empty Hashtable

    public static void broadcastMessage(String  message) {
        for (Session session : sessions.values()) {
            try {
                session.getBasicRemote().sendObject(message); // broadcast the message to websocket
                System.out.println("work: "); // for debugging
            } catch (IOException | EncodeException e) {
                e.printStackTrace();
            }
        }
    }
    @OnOpen
    public void onOpen(Session session){
        mqttlistener.start(); // print Hello on session start, for debugging
        sessions.put(session.getId(), session); //add the new session

    }
    @OnClose
    public void onClose(Session session, CloseReason reason){
        sessions.remove(session); // delete sessions when client leave
    }
    @OnError
    public void onError(Session session, Throwable error){
        System.out.println("Push WebSocket error for ID " + session.getId() + ": " + error.getMessage());
    }


}