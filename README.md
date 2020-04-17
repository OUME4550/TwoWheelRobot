Model of 2 wheeled line following robot.

## **Required Attributes:**
**Robot Attributes**
* Robot Base speed (cm/s)
* Wheel Radius of robot (cm)
* Track width of robot (cm)
* Starting Position of robot (cm)
**Sensor Attributes**
* Width of Sensor (cm)
* Distance of sensor from the robot (cm)
**Controller Attributes**
* Kp (Proportional Gain)
* Ki (Integral Gain)
* Kd (Derivative Gain)
* Controller Set Point
* Saturation Limits


## **Line Types**
There are multiple built in tracks for the line follower model to use, but it is reccomended to use the Line track for tuning the robot:

Track:

![alt text](docs/BuildTrack.PNG "BuildTrack")

Sine:

![alt text](docs/BuildSine.PNG "BuildSine")

Circle:

![alt text](docs/BuildCircle.PNG "BuildCircle")

Line: 

![alt text](docs/BuildLine.PNG "BuildLine")

