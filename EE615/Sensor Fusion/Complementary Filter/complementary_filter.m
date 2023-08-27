%------- section - 2: Reading the realtime data from IMU6050 sensor -------
ld = load('data_matlab.mat');
accelR = ld.accelR;
gyroR = ld.gyroR;
decim = 1;
duration = 0.5; % seconds
fs = 30;         % Hz
N = duration*fs;
i=1;
M = size(accelR);
%M = M(1)/N;
openExample('shared_fusion_arduinoio/EstimateOrientationUsingInertialSensorFusionAndMPU9250Example')
viewer = HelperOrientationViewer('Title',{'Visualization of Orientation'})

q = quaternion(1,0,0,0); % q_init
alpha = 0.05;
%delta_t = duration/M(1);
delta_t = 1/fs;
orientation = [q];

while i<=M(1)
    accelReadings = accelR(i,:);
    gyroReadings = gyroR(i,:);
    wx = gyroReadings(1);
    wy = gyroReadings(2);
    wz = gyroReadings(3);  
    w = [wx wy wz]';
    
    ax = accelReadings(1);
    ay = accelReadings(2);
    az = accelReadings(3);
    a = [ax ay az]';
        
    w_mat = [0 -wx -wy -wz; 
            wx 0 wz -wy; 
            wy -wz 0 wx; 
            wz wy -wx 0];
    [q0, q1, q2, q3] = parts(q);
    q_omega = quaternion(((eye(4)+delta_t/2*w_mat)*[q0, q1, q2, q3]')');
    phi = atan2(ay, az);
    theta = atan2(-ax, sqrt(ay*ay+az*az));
    psi = 0;
    
    q_accelerometer = quaternion([cos(phi/2)*cos(theta/2)*cos(psi/2)+sin(phi/2)*sin(theta/2)*sin(psi/2), sin(phi/2)*cos(theta/2)*cos(psi/2)-cos(phi/2)*sin(theta/2)*sin(psi/2), cos(phi/2)*sin(theta/2)*cos(psi/2)+sin(phi/2)*cos(theta/2)*sin(psi/2), cos(phi/2)*cos(theta/2)*sin(psi/2)-sin(phi/2)*sin(theta/2)*cos(psi/2)]);
    
    q = (1-alpha)*q_omega + alpha*q_accelerometer;
    
    orientation = [orientation;q];
    %fuse = imufilter('SampleRate',fs,'DecimationFactor',decim);
    %orientation = fuse(accelR,gyroR);
    
    % 3D figure or Sensor
    for j = numel(orientation)
       viewer(orientation(j));
    end
    
    orientationEuler = eulerd(orientation,'ZYX','frame');
    
    i=i+1;
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