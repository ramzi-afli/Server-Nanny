package com.server.nanny.util;



import com.server.nanny.models.Rack;
import com.server.nanny.models.Room;
import com.server.nanny.models.Sensor;
import com.server.nanny.models.SensorType;
import com.server.nanny.repository.RackRepository;
import com.server.nanny.repository.RoomRepository;
import com.server.nanny.repository.SensorRepository;
import org.eclipse.microprofile.config.Config;
import org.eclipse.microprofile.config.ConfigProvider;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;


import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.inject.Inject;
import javax.net.ssl.SSLSocketFactory;
import java.util.*;

import static com.server.nanny.util.PublishWebsocketEndpoint.broadcastMessage;

@Singleton
@Startup
public class MqttConnection {

    @Inject
    private RoomRepository roomRepository ;
    @Inject
    private  RackRepository rackRepository ;

    @Inject
    private SensorRepository sensorRepository ;


    private static final Config config = ConfigProvider.getConfig();
    private  final  String uri =config.getValue("mqtt.uri",String.class) ;
    private  final  String  username=config.getValue("mqtt.username",String.class);
    private  final  String password=config.getValue("mqtt.password",String.class);


    /**
     *
     * @param client
     * @param msg
     * @param topic
     * @throws MqttException
     */

    public void sendMessage(MqttClient client,String msg,String topic) throws MqttException {
        MqttMessage message = new MqttMessage(msg.getBytes());
        client.publish(topic,message);
    }



    @PostConstruct
    public void start() {
        try {
            System.out.println("\n --------------------------------------------------- \n");
            System.out.println("MQTT HAS BEEN STARTED");
            System.out.println("\n --------------------------------------------------- \n");

            //CLIENT CONNECTION OPTIONS
            /**
             * uri=protocol://domain-name:port-number
             */
            MqttClient client = new MqttClient(
                    uri,
                    MqttClient.generateClientId(),
                    new MemoryPersistence());

            MqttConnectOptions mqttConnectOptions = new MqttConnectOptions();
            mqttConnectOptions.setUserName(username);
            mqttConnectOptions.setPassword(password.toCharArray());
            mqttConnectOptions.setConnectionTimeout(0);
            mqttConnectOptions.setSocketFactory(SSLSocketFactory.getDefault()); // using the default socket factory
            client.connect(mqttConnectOptions);
            client.setCallback(new MqttCallback() {



                ///



                @Override
                // Called when the client lost the connection to the broker
                public void connectionLost(Throwable cause) {
                    System.out.println("\n --------------------------------------------------- \n");
                    System.out.println("CLIENT LOST CONNECTION " + cause);
                    System.out.println("\n --------------------------------------------------- \n");

                }




                /**
                 *
                 * @param topic
                 * @param message
                 * @javadoc this func is activated when new data is streamed
                 */

                @Override
                public void messageArrived(String topic, MqttMessage message) {

                    if(topic.equals("room")){
                        Room room =new Room() ;
                        room.setId(message.toString());
                        room.setUserEmail(" ");
                        roomRepository.save(room);
                    }if(topic.equals("/")){
                        broadcastMessage(message.toString());
                    }if(topic.equals("room/rack")){
                        Rack rack=new Rack() ;
                        rack.setId(message.toString().split("/")[1]);
                        rack.setRoomId(message.toString().split("/")[0]);
                        rackRepository.save(rack);
                    }if(topic.equals("room/rack/sensor")){
                        if(!sensorRepository.findById(message.toString().split("/")[1]).isPresent()){
                            Sensor sensor=new Sensor() ;
                            sensor.setId(message.toString().split("/")[1]);
                            sensor.setRack(message.toString().split("/")[0]);
                            sensor.setType(SensorType.valueOf(message.toString().split("/")[2]));
                            double value=Double.valueOf(message.toString().split("/")[3] ) ;
                            List<Double> values =new ArrayList<>();
                            values.add(0,value) ;
                            sensor.setValues(values);
                            sensorRepository.save(sensor);
                        }else {
                            //else we  add a sensor value
                            Sensor sensor=sensorRepository.findById(message.toString().split("/")[1]).get();
                            List<Double> sensorValues =new ArrayList<>();
                            sensorValues=sensor.getValues() ;
                            double value=Double.valueOf(message.toString().split("/")[3] ) ;
                            sensorValues.add(0,value);
                            sensor.setValues(sensorValues);
                            sensorRepository.save(sensor);
                        }




                    }


                }




                /**
                 *
                 * @param token
                 * @javadoc this func is activated when we produce data
                 */
                @Override
                public void deliveryComplete(IMqttDeliveryToken token) {
                }
            });


            client.subscribe("room", 1);
            client.subscribe("room/rack", 1);
            client.subscribe("room/rack/sensor", 1);

        } catch (MqttException e) {

        }
    }
}