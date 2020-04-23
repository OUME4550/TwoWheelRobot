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
        lastError = 0;
        lastRunT = 0;
        saturationLimit = 0;
        navg = 5;
        errorHistory;
    end
    methods      
        function obj = Controller()
            obj.errorHistory = zeros(1,obj.navg);
        end
        function newControlValue = GetNewControlValue(obj)
            newControlValue = obj.output;
        end
        function obj = Update(obj, newInput, currentT)
            timeDuration = currentT - obj.lastRunT;
            if(timeDuration > obj.dt)
                error = newInput - obj.setpoint;
                %add new element
                if(isempty(obj.errorHistory))
                    obj.errorHistory = error;
                else
                    obj.errorHistory = [obj.errorHistory error];
                end
                %remove old value
                if(length(obj.errorHistory) > obj.navg)
                    obj.errorHistory = obj.errorHistory(2:obj.navg+1);
                end
                error = mean(obj.errorHistory);
                
                obj.sumError = error*obj.dt + obj.sumError;
                
                dInput = (error - obj.lastError)/obj.dt;

                newoutput = obj.kp*error + obj.kd*dInput + obj.ki * obj.sumError;

                if(newoutput > obj.saturationLimit)
                    newoutput = obj.saturationLimit;
                elseif(newoutput < -obj.saturationLimit)
                    newoutput = -obj.saturationLimit;
                end
                obj.output = newoutput;

                obj.lastError = error;
                obj.lastRunT = currentT;
            else
                obj.output = NaN;
            end
        end
   end
end