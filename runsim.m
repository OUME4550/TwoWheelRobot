%% DDR simulation
clear variables; close all;

%seconds
simdt = 0.01;
controllerdt = simdt*3;
%% Path for Line follower
line = LineConstruct;
% line = line.buildSine();
% line = line.buildCircle();
line = line.buildLine();
line = line.buildTrack();



%% Line Follower Robot 
robot = DDR; 

%cm/s
robot.baseSpd = 5;       % Robot Base Speed
%cm
robot.WheelRadius = 2;                % Wheel Radius
robot.AxelLen = 2;                % Wheel Axle Length
%Starting Position
%cm
robot.x = 50;  
robot.y = 48;

%radians
robot.theta = deg2rad(5);                
robot.dt = simdt;            % Time step

%% Line Follower Sensor
%cm
SensorWidth = 5; 
SensorDistanceFromRobotCenter = 2; 
sensor = IR_sensor;


%% PID Controller
controller = Controller;
controller.kp = 0.05;             % Proportional 
controller.ki = 0.1;             % Integral
controller.kd = 0.01;              % Derivative
controller.dt = controllerdt;
controller.setpoint = 0;
controller.saturationLimit = 0.25;
fig1=figure;hold all;

graphZoomOnRobot = true;

i = 1;
t=0:simdt:30;
for i=1:length(t)
    %do a sensor reading to get data
    sensor = sensor.buildSensor(robot.x, robot.y, robot.theta, SensorWidth, SensorDistanceFromRobotCenter);
    sensorReading = sensor.readBar( line.Linex, line.Liney);
    sensorHistory(i) = sensorReading;
    %no sensor data, so keep going straight or stop
    if sensorReading == -1
        robot = robot.continueKinematicsWithHeading();
        disp('cannot find the line');
        break;
    else %on the line, need some control guidance!
        controller = controller.Update(sensorReading, i*simdt);
        requestedDiff = controller.GetNewControlValue();
        if ~isnan(requestedDiff) %not time to run the controller
            newDiffSpeedControl = requestedDiff;
        else
            newDiffSpeedControl = 0;
        end
      
        %update kinematics (move the robot)
        robot = robot.DDR_Kinematics(robot.baseSpd, newDiffSpeedControl);       
    end
        
    if(mod(i,5)==0)
        cla;
        plot(line.Linex, line.Liney,'g','Linewidth',3);
        n = scatter(robot.x, robot.y, 75,'m');
        q = plot(sensor.bar(1,:) , sensor.bar(2,:));
        if graphZoomOnRobot
            xlim([robot.x-20 robot.x+20]);
            ylim([robot.y-20 robot.y+20]);
        else
            xlim([-25 150]);
            ylim([-10 60]);
            axis equal;
        end
        xlabel('X [cm]');
        ylabel('Y [cm]');
        grid on;
        drawnow();
    end
    i = i+1; 

end

