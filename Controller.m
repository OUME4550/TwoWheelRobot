classdef Controller
    %CONTROLLER 
    properties

        setpoint = 0;
        output = nan;
        dt = 0;
        kp = 0;
        ki =0;
        kd =0;
        
        sumError = 0;
        lastInput = 0;
        lastRunT = 0;
        saturationLimit = 0;
    end
    methods      
        function newControlValue = GetNewControlValue(obj)
            newControlValue = obj.output;
        end
        function obj = Update(obj, newInput, currentT)
            timeDuration = currentT - obj.lastRunT;
            if(timeDuration > obj.dt)
                error = newInput - obj.setpoint;
                obj.sumError = error*obj.dt + obj.sumError;

                dInput = (error - obj.lastInput)/obj.dt;

                newoutput = obj.kp*error + obj.kd*dInput + obj.ki * obj.sumError;

                if(newoutput > obj.saturationLimit)
                    newoutput = obj.saturationLimit;
                elseif(newoutput < -obj.saturationLimit)
                    newoutput = -obj.saturationLimit;
                end
                obj.output = newoutput;

                obj.lastInput = newInput;
                obj.lastRunT = currentT;
            else
                obj.output = NaN;
            end
        end
   end
end