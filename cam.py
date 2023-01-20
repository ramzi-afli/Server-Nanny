

# import the necessary packages
from picamera.array import PiRGBArray # Generates a 3D RGB array
from picamera import PiCamera # Provides a Python interface for the RPi Camera Module
import time # Provides time-related functions
import cv2 # OpenCV library
import numpy as np
from PIL import Image
import tensorflow as tf
from keras.preprocessing import image
import paho.mqtt.client as mqtt

# Define event callbacks
def on_connect(client, userdata, flags, rc):
    print("rc: " + str(rc))

def on_message(client, obj, msg):
    print(msg.topic + " " + str(msg.qos) + " " + str(msg.payload))
    
def on_publish(client, obj, mid):
    print("mid: " + str(mid))

def on_subscribe(client, obj, mid, granted_qos):
    print("Subscribed: " + str(mid) + " " + str(granted_qos))

def on_log(client, obj, level, string):
    print(string)

username = "ramzi-afli"              # mqtt username
password = "28640raaf"              # mqtt password


mqttc = mqtt.Client()
# Assign event callbacks
mqttc.on_message = on_message
mqttc.on_connect = on_connect
mqttc.on_publish = on_publish
mqttc.on_subscribe = on_subscribe

# Uncomment to enable debug messages
#mqttc.on_log = on_log

topic = "room/rack/sensor"

# Connect
mqttc.username_pw_set(username, password)
# create connection, the three parameters are broker address, broker port number, and keep-alive time respectively
broker="wss://mqtt.server-nanny.me"
port=1883
mqttc.connect(broker, port)
mqtt_client = mqtt.Client("", True, None, mqtt.MQTTv31)

# Start subscribe, with QoS level 0
mqttc.subscribe(topic, 0)

mqttc.loop_forever()

while rc == 0 :


    # Initialize the camera
    camera = PiCamera()

    # Set the camera resolution
    camera.resolution = (224, 224)

    # Set the number of frames per second
    camera.framerate = 32

    # Generates a 3D RGB array and stores it in rawCapture
    raw_capture = PiRGBArray(camera, size=(224, 224))

    # Wait a certain number of seconds to allow the camera time to warmup
    time.sleep(0.1)
    model = tf.keras.models.load_model('/home/pi/Desktop/InceptionV3.h5')
    i = 0
    # Capture frames continuously from the camera
    for frame in camera.capture_continuous(raw_capture, format="bgr", use_video_port=True):

        # Grab the raw NumPy array representing the image
        im = frame.array
        np.resize(im,(224,224))
        #cv2.imwrite(str(i) + ".jpg", im)
        img_array = image.img_to_array(im)
        cv2.imwrite(str(i) + ".jpg", img_array)
        img_array = np.expand_dims(img_array, axis=0) / 255
        probabilities = model.predict(img_array)[0]
        #Calling the predict method on model to predict 'fire' on the image
        prediction = np.argmax(probabilities)
        #if prediction is 0, which means there is fire in the frame.
        if prediction == 0:
        	#frame = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
        	print(probabilities[prediction])
        print(prediction)
        i += 1
        # Display the frame using OpenCV
        #cv2.imshow("Frame", image)
        mqttc.publish("rack1/sensor3/CAMERA", str(prediction))
        # Wait for keyPress for 1 millisecond
        key = cv2.waitKey(1) & 0xFF

        # Clear the stream in preparation for the next frame
        raw_capture.truncate(0)

        # If the `q` key was pressed, break from the loop
        if key == ord("1"):
            break
