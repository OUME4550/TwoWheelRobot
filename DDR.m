classdef DDR
    %DDR class for two wheel Differential Drive Robot (DDR)
     
    properties
        WheelRadius       % DDR wheel radius (in)
        AxelLen        % DDR axle lenght  (in)
         
        x             % x-coordinate of center axel of DDR
        y             % y-coordinate of center axel of DDR
        
        x_history = []
        y_history = []
        
        theta       % Direction of travel for the DDR
        
        baseSpd
        
        dt     % time step               
        
    end
    
    methods % DDR Kinematics
       
        function obj = DDR_Kinematics(obj, baseSpeed, diffW)
            vr = baseSpeed + diffW;
            vl = baseSpeed - diffW;
            phi = obj.WheelRadius *(vr-vl)/(2*obj.AxelLen);

            th = obj.theta + phi;
            % obj.theta = mod(obj.theta,360);
            vx = (obj.WheelRadius/2)*(vr+vl)*cos(th);
            vy = (obj.WheelRadius/2)*(vr+vl)*sin(th);

            % Update position of robot in Inertial frame
            obj.x = obj.x + vx*obj.dt;
            obj.y = obj.y + vy*obj.dt;
            %save path
            obj.x_history = [obj.x_history, obj.x];
            obj.y_history = [obj.y_history, obj.y];
            obj.theta = th;
        end 
        
        function obj = continueKinematicsWithHeading(obj)  
            obj = obj.DDR_Kinematics(obj.baseSpd, 0);                                            
        end
             
    end
    
end

