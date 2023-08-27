%------- section - 1: Interfacing IMU6050 sensor with Arduino Mega250 -------
clc;
clear all;
% a = arduino(); %Update the name of communication port
a = arduino('COM5', 'Mega2560', 'Libraries', 'I2C');
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

delta_t = 1/fs;

while i<N
    
    [accelReadings, gyroReadings] = read(imu)
    i=i+1;
    accelR = [accelR;accelReadings]
    gyroR = [gyroR;gyroReadings]
    
    fuse = imufilter('SampleRate',fs);
    orientationMatlab = fuse(accelR,gyroR);
    
    countSamples = size(accelR, 1);
    delta_t = 1/fs;
    orientation = quaternion.zeros(countSamples, 1);
    [current_attitude, P_mat, variance_gyro, variance_accel] = initialize(accelR(1,:));
    for idx = 1:countSamples
        accelReadings = accelR(idx,:);
        gyroReadings = gyroR(idx,:);
        [current_attitude,P_mat] = prediction(current_attitude, gyroReadings, P_mat, variance_gyro, delta_t);
        [current_attitude,P_mat] = correction(current_attitude, accelReadings, P_mat, variance_accel);
        orientation(idx, :) = current_attitude;
    end
    % 3D figure or Sensor
    for j = numel(orientation)
       viewer(orientation(j));
    end
    
    orientationEuler = eulerd(orientation,'ZYX','frame');
    orientationEulerMatlab = eulerd(orientationMatlab,'ZYX','frame');
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

figure
subplot(2,1,1)
plot(eulerd( orientation, 'ZYX', 'frame'));
title('Orientation Estimate');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
xlabel('Sample')
ylabel('Degrees');

subplot(2,1,2)
plot(eulerd( orientationMatlab, 'ZYX', 'frame'));
title('Orientation Estimate');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
xlabel('Sample')
ylabel('Degrees');

figure
subplot(2,3,1)
plot(orientationEuler(:,1))
ylabel('Degrees')
xlabel('Sample')
subplot(2,3,2)
plot(orientationEuler(:,2))
ylabel('Degrees')
xlabel('Sample')
subplot(2,3,3)
plot(orientationEuler(:,3))
ylabel('Degrees')
xlabel('Sample')
subplot(2,3,4)
plot(orientationEulerMatlab(:,1))
ylabel('Degrees')
xlabel('Sample')
subplot(2,3,5)
plot(orientationEulerMatlab(:,2))
ylabel('Degrees')
xlabel('Sample')
subplot(2,3,6)
plot(orientationEulerMatlab(:,3))
ylabel('Degrees')
xlabel('Sample')


%3D curve
figure
subplot(2,1,1)
plot3(orientationEuler(:,1),orientationEuler(:,2),orientationEuler(:,3))
legend('Z-axis','Y-axis','X-axis')
xlabel('Time (s)')
ylabel('Rotation (degrees)')
title('Estimated Orientation')

subplot(2,1,2)
plot3(orientationEulerMatlab(:,1),orientationEulerMatlab(:,2),orientationEulerMatlab(:,3))
legend('Z-axis','Y-axis','X-axis')
xlabel('Time (s)')
ylabel('Rotation (degrees)')
title('Estimated Orientation')

function [q_0, P_0, variance_gyro, variance_accel] = initialize(accel)
%     accel_normalized = (accel/norm(accel))';
%     C = [[0;0;0] [0;0;0] accel_normalized];     
%     q_0 = quaternion(sqrt(C(1,1)+C(2,2)+C(3,3)+1), sign(C(3,2)-C(2,3))*sqrt(C(1,1)-C(2,2)-C(3,3)+1), sign(C(1,3)-C(3,1))*sqrt(C(2,2)-C(1,1)-C(3,3)+1), sign(C(2,1)-C(1,2))*sqrt(C(3,3)-C(2,2)-C(1,1)+1));
%     q_0 = normalize(q_0);
    q_0 = quaternion(1,0,0,0);
    P_0 = eye(4);
    variance_gyro = 0.3^2;
    variance_accel = 0.5^2;
end
function [new_quat,new_P_mat] = prediction(quat, w, P_mat, variance_gyro, delta_t)
    [qw, qx, qy, qz] = parts(quat);
    wx = w(1);
    wy = w(2);
    wz = w(3);
    Omega_matrix = [0 -wx -wy -wz;
                    wx 0 wz  -wy;
                    wy -wz 0 wx;
                    wz wy -wx 0];
    % new_quat = quaternion(((cos(norm(w)*delta_t/2)*eye(4)+(2/norm(w))*sin(norm(w)*delta_t/2)*Omega_matrix)*[qw, qx, qy, qz]')');
    
    F_mat = eye(4)+(delta_t/2)*Omega_matrix;
    new_quat = quaternion((F_mat*[qw, qx, qy, qz]')');
    W_mat = (delta_t/2)*[-qx -qy -qz;
                qw -qz qy;
                qz qw -qx;
                -qy qx qw];
    Q_mat = variance_gyro*(W_mat*W_mat');
    new_P_mat = F_mat*P_mat*F_mat' + Q_mat;
end
function [q_t,P_t] = correction(quat, accel, P_mat, variance_accel)
    [qw, qx, qy, qz] = parts(quat);
    accel_normalized = accel/norm(accel);
    z_t = accel_normalized';
    C_mat = [1-2*(qy^2+qz^2)     2*(qx*qy-qw*qz)      2*(qx*qz+qw*qy);
            2*(qx*qy+qw*qz)     1-2*(qx^2+qz^2)     2*(qy*qz-qw*qx);
            2*(qx*qz-qw*qy)     2*(qw*qx+qy*qz)     1-2*(qx^2+qy^2)]; 
    g = [0 0 1]';
    gz = g(3);
    a_hat = C_mat'*g;
    h_vec = a_hat;
    H_mat = 2*[-gz*qy     gz*qz     -gz*qw     gz*qx;
                gz*qx     gz*qw      gz*qz     gz*qy;
                0         -2*gz*qx   -2*gz*qy     0];
    R_mat = variance_accel*eye(3);
    v_t = z_t - h_vec;
    S_t = H_mat*P_mat*H_mat' + R_mat;
    K_t = (P_mat*H_mat')*inv(S_t);
    q_t = quat+quaternion((K_t*v_t)');
    P_t = (eye(4)-K_t*H_mat)*P_mat;
    q_t = sign(parts(q_t))*q_t;
    q_t = normalize(q_t);
end