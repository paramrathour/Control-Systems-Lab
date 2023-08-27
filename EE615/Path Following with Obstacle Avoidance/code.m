%% Path Following with Obstacle Avoidance in Simulink®
% This example shows you how to use Simulink to avoid obstacles while following 
% a path for a differential drive robot. This example uses ROS to send and receive 
% information from a MATLAB®-based simulator. You can replace the simulator with 
% other ROS-based simulators such as Gazebo®.
% 
% Prerequisites: <docid:robotics_examples.mw_5c631521-58fd-4507-81f0-37f5e0c19209 
% Connect to a ROS-enabled Robot from Simulink>
%% Introduction
% This example uses a model that implements a path following controller with 
% obstacle avoidance. The controller receives the robot pose and laser scan data 
% from the simulated robot and sends velocity commands to drive the robot on a 
% given path. You can adjust parameters while the model is running and observe 
% the effect on the simulated robot.
%% Task 1 - Start a Robot Simulator
% Start a simple MATLAB-based simulator:
rosinit;
%%
ExampleHelperSimulinkRobotROS('ObstacleAvoidance');
% * Type |rosinit| at the MATLAB command line. This creates a local ROS master 
% with network address (URI) of |http://localhost:11311|.
% * Type |ExampleHelperSimulinkRobotROS('ObstacleAvoidance')| to start the Robot 
% Simulator. This opens a figure window:
%% 
% % 
% This MATLAB-based simulator is a ROS-based simulator for a differential-drive 
% robot. The simulator receives and sends messages on the following topics:
%% 
% * It receives velocity commands, as messages of type "geometry_msgs/Twist", 
% on the "/mobile_base/commands/velocity" topic
% * It sends ground truth robot pose information, as messages of type "nav_msgs/Odometry", 
% to the "/ground_truth_pose" topic
% * It sends laser range data, as messages of type "sensor_msgs/LaserScan", 
% to the "/scan" topic
%% 
% Replacing the MATLAB-based simulator with Gazebo:
% 
% You can also use Gazebo simulator with a simulated TurtleBot®. See <docid:robotics_examples.mw_67613a68-e2b2-40ab-9c52-00e2ec28e7df 
% Get Started with Gazebo and a Simulated TurtleBot> for instructions on setting 
% up the Gazebo environment. See <docid:robotics_examples.mw_5c631521-58fd-4507-81f0-37f5e0c19209 
% Connect to a ROS-enabled Robot from Simulink> for instructions on setting up 
% network connection with Gazebo. You also need a localization algorithm to get 
% robot position in the Gazebo. See <docid:robotics_examples.mw_70d11cb2-43ee-4a16-a6ef-1431b8b9c875 
% Localize TurtleBot Using Monte Carlo Localization> for instructions on finding 
% robot location in Gazebo environment.
%% Task 2 - Open Existing Model
% This <matlab:pathFollowingWithObstacleAvoidanceExample model> implements the 
% path following with obstacle avoidance algorithm. The model is divided into 
% four subsystems. The following sections explain each subsystem.

open_system('pathFollowingWithObstacleAvoidanceExample');
%% 
% *Process Inputs*
% 
% The 'Inputs' subsystem processes all the inputs to the algorithm.
% 
% There are two subscribers to receive data from the simulator. The first subscriber 
% receives messages sent on the "/scan" topic. The laser scan message is then 
% processed to extract scan ranges and angles. The second subscriber receives 
% messages sent on the "/ground_truth_pose" topic. The (x,y) location and Yaw 
% orientation of the robot is then extracted from the pose message.
% 
% The path is specified as a set of waypoints. This example uses a 3x2 constant 
% input. You can specify any number of waypoints as an Nx2 array. To change the 
% size of the path at run-time, you can either use a variable sized signal or 
% use a fixed size signal with |NaN| padding. This example uses a fixed size input 
% with |NaN| padding for the waypoints that are unknown.

open_system('pathFollowingWithObstacleAvoidanceExample/Inputs', 'tab');
%% 
% *Compute Velocity and Heading for Path Following*
% 
% The 'Compute Velocity and Heading for Path Following' subsystem computes the 
% linear and angular velocity commands and the target moving direction using the 
% *Pure Pursuit*.
% 
% You also need to stop the robot once it reaches a goal point. In this example, 
% the goal is the last waypoint on the path. This subsystem also compares the 
% current robot pose and the goal point to determine if the robot is close to 
% the goal.

open_system('pathFollowingWithObstacleAvoidanceExample/Compute Velocity and Heading for Path following', 'tab');
%% 
% *Adjust Velocities to Avoid Obstacles*
% 
% The 'Adjust Velocities to Avoid Obstacles' subsystem computes adjustments 
% to the linear and angular velocities computed by the path follower.
% 
% The Vector Field Histogram uses the laser range readings to check if 
% the target direction computed using the Pure Pursuit block is obstacle-free 
% or not based on the laser scan data. If there are obstacles along the target 
% direction, the Vector Field Histogram computes a steering direction that 
% is closest to the target direction and is obstacle-free. The Vector Field Histogram 
% block is also located in the _Mobile Robot Algorithms_ sub-library.
% 
% The steering direction is |NaN| value when there are no obstacle-free directions 
% in the sensor field of view. In this case, a recovery motion is required, where 
% the robot turns on-the-spot until an obstacle-free direction is available.
% 
% Based on the steering direction, this subsystem computes adjustments in linear 
% and angular velocities.

open_system('pathFollowingWithObstacleAvoidanceExample/Adjust Velocities to Avoid Obstacles', 'tab');
%% 
% *Send Velocity Commands*
% 
% The 'Outputs' subsystem publishes the linear and angular velocities to drive 
% the simulated robot. It adds the velocities computed using the Pure Pursuit 
% path following algorithm with the adjustments computed using the Vector Field 
% Histogram obstacle avoidance algorithm. The final velocities are set on the 
% "geometry_msgs/Twist" message and published on the topic "/mobile_base/commands/velocity".
% 
% This is an enabled subsystem which is triggered when new laser message is 
% received. This means a velocity command is published only when a new sensor 
% information is available. This prevents the robot from hitting the obstacles 
% in case of delay in receiving sensor information.

open_system('pathFollowingWithObstacleAvoidanceExample/Outputs', 'tab');
%% Task 3 - Configure and Run the Model
% Configure and run your model and observe the motion of the robot in the simulator.
%% 
% * Set simulation Stop time to |Inf|.
% * Click the Play button to start simulation. Observe that the robot starts 
% moving in the simulation.
% * While the simulation is running, open 'Compute Velocity and Heading for 
% Path Following' subsystem and double-click on the *Pure Pursuit* block. Change 
% the desired linear velocity parameter to |0.5|. Observe increase in the velocity 
% of the robot.
% * The default path |[2 2;8 8]| passes through an obstacle. Observe that the 
% robot takes a detour around the obstacle to reach the end point of the path.
% * Open the 'Inputs' subsystem and double-click on the *Waypoints Input* block. 
% Change the constant value from |[2 2;8 8;NaN NaN]| to |[2 2;8 8;12 5]|. Notice 
% that robot continues to follow the new path and reaches the new goal point |[12, 
% 5]| while avoiding obstacles.
% * To stop the simulation, click the Stop button.
%% 
% %% Summary
% This example showed you how to create a path following controller with obstacle 
% avoidance.
%% See Also
%% 
% * <docid:robotics_examples.mw_7fd23777-a1eb-4d71-b419-542f20d75bdc Generate 
% a Standalone ROS Node from Simulink>
% * <docid:robotics_examples.mw_04f9e096-7491-4efd-8380-9d7e178f95b6 Path Planning 
% in Environments of Different Complexity>
%% 
% _Copyright 2016 The MathWorks, Inc._