%------- section - 1: Interfacing IMU6050 sensor with Arduino Mega250 -------
clc;
clear all;
% a = arduino(); %Update the name of communication port
a = arduino('COM3', 'Mega2560', 'Libraries', 'I2C');
fs = 20; % Sample Rate in Hz   
imu = mpu6050(a,'SampleRate',fs,'OutputFormat','matrix'); 
%%
%------- section - 2: Reading the realtime data from IMU6050 sensor -------
decim = 1;
duration = 1; % seconds
fs = 20;         % Hz
N = duration*fs;
i=0;

accelR=[];
gyroR=[];

openExample('shared_fusion_arduinoio/EstimateOrientationUsingInertialSensorFusionAndMPU9250Example')
viewer = HelperOrientationViewer('Title',{'Visualization of Orientation'})

while i<N
    
    [accelReadings, gyroReadings] = read(imu)
    i=i+1;
    accelR = [accelR;accelReadings]
    gyroR = [gyroR;gyroReadings]
    
    fuse = imufilter('SampleRate',fs,'DecimationFactor',decim);
    orientation = fuse(accelR,gyroR);
    
    % 3D figure or Sensor
    for j = numel(orientation)
       viewer(orientation(j));
    end
    
    orientationEuler = eulerd(orientation,'ZYX','frame');
end

N=N*10;
timeVector = (0:(N-1))/fs;
figure
subplot(2,1,1)
plot(timeVector,accelR)
legend('X-axis','Y-axis','Z-axis')
ylabel('Acceleration (m/s^2)')
title('Accelerometer Readings')

subplot(2,1,2)
plot(timeVector,gyroR)
legend('X-axis','Y-axis','Z-axis')
ylabel('Angular Velocity (rad/s')
xlabel('Time (s)')
title('Gyroscope Readings')


%3D curve
figure
plot3(orientationEuler(:,1),orientationEuler(:,2),orientationEuler(:,3))
legend('Z-axis','Y-axis','X-axis')
xlabel('Time (s)')
ylabel('Rotation (degrees)')
title('Estimated Orientation')

