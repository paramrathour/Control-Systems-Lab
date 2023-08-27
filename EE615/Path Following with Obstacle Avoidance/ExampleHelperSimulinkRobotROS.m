classdef ExampleHelperSimulinkRobotROS < handle
    %ExampleHelperSimulinkRobotROS Setup robot simulator for Simulink
    %examples
    %
    %   This class is included only for demonstration purposes. The name of
    %   this class and its functionality may change without notice in a
    %   future release, or the class itself may be removed.
    %
    %   See also ExampleHelperRobotSimulator
    
    %   Copyright 2015-2016 The MathWorks, Inc.
    
    properties (Access = public)
        %Simulator - Robot Simulator
        %   See also ExampleHelperRobotSimulator.
        Simulator
    end
    
    methods
        function obj = ExampleHelperSimulinkRobotROS(varargin)
            %ExampleHelperSimulinkRobotROS Configure robot simulator for
            %simulink example.
            
            switch nargin
                case 1       
                    % Setup for Path Following with Obstacle Avoidance
                    % Example in Simulink
                    
                    validatestring(varargin{1}, {'ObstacleAvoidance'});
                    % Setup RobotSimulator with simple map
                    obj.Simulator = ExampleHelperRobotSimulator('simpleMap');
                    
                    % Set robot's maximum speed
                    obj.Simulator.Robot.MaxLinearVelocity = 2;
                    obj.Simulator.Robot.MaxAngularVelocity = 1;
                    % Set robot's initial pose
                    obj.Simulator.setRobotPose([2,4,0]);
                    % Set robot's size (bounding radius)
                    obj.Simulator.setRobotSize(0.5);
                    % Enable ROS interface for simulator
                    obj.Simulator.enableROSInterface(true);
                    % Disable Laser sensor
                    obj.Simulator.enableLaser(true);
                    % Disable velocity command timeout, i.e. the robot will follow the latest
                    % velocity command indefinitely.
                    obj.Simulator.Robot.enableLimitedCommandTime(true);   
                    % Enable trajectory plot
                    obj.Simulator.showTrajectory(true);
                otherwise
                    % Setup RobotSimulator with empty map
                    map = robotics.BinaryOccupancyGrid(false(50), 1);
                    map.GridLocationInWorld = [-25, -25];
                    obj.Simulator = ExampleHelperRobotSimulator(map);
                    
                    % Set robot's maximum speed
                    obj.Simulator.Robot.MaxLinearVelocity = 2;
                    obj.Simulator.Robot.MaxAngularVelocity = 1;
                    % Set robot's initial pose
                    obj.Simulator.setRobotPose([0,0,0]);
                    % Set robot's size (bounding radius)
                    obj.Simulator.setRobotSize(2);
                    % Enable ROS interface for simulator
                    obj.Simulator.enableROSInterface(true);
                    % Disable Laser sensor
                    obj.Simulator.enableLaser(false);
                    % Disable velocity command timeout, i.e. the robot will follow the latest
                    % velocity command indefinitely.
                    obj.Simulator.Robot.enableLimitedCommandTime(false);
                    
                    % Turn grid on
                    grid(obj.Simulator.Axes, 'on');
            end
            
        end
        
        function delete(obj)
            %delete Clean up robot simulator.
            delete(obj.Simulator)
        end
    end
    
end

