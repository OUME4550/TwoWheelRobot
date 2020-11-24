classdef LineConstruct
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        Linex
        Liney
        
        start = 0;
        lineEnd = 100;
        step = 10000;
       
        
    end
    
    methods
        function obj = buildTrack(obj)
            nump = 100;
            linedist = 100;
            radius = 25;
            offsetX = radius;
            topX = linspace(offsetX, linedist, nump);
            topY = radius*2.*ones(1,nump);
            
            bottomX = linspace(linedist, offsetX, nump);
            bottomY = 0.*ones(1,nump);
            
            theta = linspace(0, pi, nump);
            rightX = radius.*sin(theta)-radius+ offsetX+linedist;
            rightY = radius.*cos(theta)+radius;
            
            theta = linspace(pi, 0, nump);
            leftX = -radius.*sin(theta)+offsetX;
            leftY = radius.*cos(theta)+radius;
            
            
%             figure;hold all;
%             scatter(rightX, rightY);
%             scatter(leftX, leftY);
%             scatter(topX, topY);
%             scatter(bottomX, bottomY);
%             xlim([0 100]);
%             ylim([0 100]);
%             axis equal;
%             grid on;
            obj.Linex = [topX rightX bottomX leftX];
            obj.Liney = [topY rightY bottomY leftY];
        end
        
        function obj = buildSine(obj)

            pathTheta = linspace(obj.start,obj.lineEnd,obj.step);
            obj.Liney = 15*sin(0.1*pathTheta)+45;
            obj.Linex = pathTheta;
            
        end
    
        function obj = buildCircle(obj)
            radius = 20;
            pathTheta = linspace(0*pi/180, 360*pi/180, 360);
            obj.Linex = radius*sin(pathTheta)+50;
            obj.Liney = radius*cos(pathTheta)+65;        
        end
        
        function obj = buildLine(obj)
%             pathTheta = linspace(obj.start,obj.lineEnd,obj.step);   % theta values - realy for the cos and sin fuctions
%             obj.Linex = -pathTheta;
%             obj.Liney = pathTheta;
%               obj.Linex = [0 1000];
%               obj.Liney = [50 50];
              obj.Linex = linspace(0,1000,1000);
              obj.Liney = 50*ones(1,1000);
        end
        
        
    end
    
end

