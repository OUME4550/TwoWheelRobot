classdef IR_sensor
    %IR_SENSOR Summary of this class goes here

    properties          
        bar   
        Length
    end   
    methods       
        function obj = buildSensor(obj, x, y, theta, Length, DistSeperation)
            origin = [x y];
            xytopL = [x+DistSeperation      y+Length/2];
            xyMID = [x+DistSeperation       y];
            xybotL = [x+DistSeperation      y-Length/2];
            pts = [xytopL;xyMID;xybotL];%;xybotR;xybotL;xytopL];

            scatter(x,y);
            theta = -theta;
            Rot = [cos(theta) -sin(theta);...
                   sin(theta) cos(theta)];
            Rpts = origin + (pts - origin) * Rot;
%             scatter(Rpts(:,1),Rpts(:,2));
            obj.bar = Rpts';
            obj.Length = Length;
        end   
        function obj = PlotBar(obj,Linex,Liney)
            scatter(obj.bar(1,:),obj.bar(2,:));
            line = [Linex; Liney];
%             Q = InterX(obj.bar, line); 
%             scatter(Q(1),Q(2));
        end
        function D = readBar(obj, Linex, Liney)
            line = [Linex; Liney];
            Q = InterX(obj.bar, line);   
            if isempty(Q) == false
%                 Pm = [obj.bar(1,2);obj.bar(2,2)];
%                 Pt = [obj.bar(1,1);obj.bar(2,1)];
                Pb = [obj.bar(1,3);obj.bar(2,3)];
                D = pdist([Q';Pb'],'euclidean');
                D = D - obj.Length/2;
                D = D(1); %sometimes > 1 solution, dump others
            else
                D = -1;
            end
        end
                         
    end
    
end

