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
AccelerometerGain = 0.01;
threshold = 0.9;
omegaThreshold = 0.2;
accelerationThreshold = 0.1;
deltaomegaThreshold = 0.01;
accelerometerBias = [8.4208 0.3461 5.2420];
gyrometerBiasAlpha = 0.01;
qI = quaternion(1,0,0,0);
g = 9.81;

while i<N
    
    [accelReadings, gyroReadings] = read(imu)
    i=i+1;
    accelR = [accelR;accelReadings]
    gyroR = [gyroR;gyroReadings]
    
    fuse = complementaryFilter('SampleRate',fs,'HasMagnetometer',false);
    orientationMatlab = fuse(accelR,gyroR);
    
    current_attitude = qI;
    
    gyrometerBias = [0 0 0];
    prevOmega = [0 0 0];
    countSamples = size(accelR, 1);
    omega = zeros(countSamples, 3);
    orientation = quaternion.zeros(countSamples, 1);
    
    for idx = 1:countSamples
        accelReadings = accelR(idx,:);
        gyroReadings = gyroR(idx,:);
        accelMagnitude = norm(accelReadings);

        w1 = gyroReadings(1);
        w2 = gyroReadings(2);
        w3 = gyroReadings(3);  

        if (abs(accelMagnitude - g) <= accelerationThreshold) && (abs(w1-prevOmega(1)) <= deltaomegaThreshold) && (abs(w2-prevOmega(2)) <= deltaomegaThreshold) && (abs(w3-prevOmega(3)) <= deltaomegaThreshold) && (abs(w1 - gyrometerBias(1)) <= omegaThreshold) && (abs(w2 - gyrometerBias(2)) <= omegaThreshold) && (abs(w3 - gyrometerBias(3)) <= omegaThreshold)
            gyrometerBias = gyrometerBias + gyrometerBiasAlpha * (gyroReadings - gyrometerBias);
        end
        prevOmega = gyroReadings;
        omega(idx,:) = gyroR(idx,:) - gyrometerBias;

        current_attitude = current_attitude * quaternion((gyroReadings-gyrometerBias)*delta_t, 'rotvec');

        accelNormalized = accelReadings/norm(accelReadings);
        predicted_gravity = rotatepoint(current_attitude, accelNormalized);

        % Correction
        deltaAcceleration0 = sqrt((predicted_gravity(3) + 1) / 2);
        deltaAcceleration1 = predicted_gravity(2) / sqrt(2*(predicted_gravity(3)+1));
        deltaAcceleration2 = -predicted_gravity(1) / sqrt(2*(predicted_gravity(3)+1));
        deltaAcceleration3 = 0;
        deltaAcceleration = quaternion(deltaAcceleration0, deltaAcceleration1, deltaAcceleration2, deltaAcceleration3);


        temp = abs(accelMagnitude - g);
        if temp <= 0.1
            accelGainFactor = 1;
        elseif temp < 0.2
            accelGainFactor = 2 - temp/0.1;
        else
            accelGainFactor = 0;
        end
        accelGain = AccelerometerGain * accelGainFactor;
        if deltaAcceleration0 > threshold
            corr_deltaAccel = (1-accelGain)*qI+accelGain*deltaAcceleration;
        else
            Omega = acos(deltaAcceleration0);
            corr_deltaAccel = (sin((1-accelGain*Omega)/sin(Omega))*qI + (sin(accelGainFactor)*Omega)/sin(Omega))*deltaAcceleration;
        end
        corr_deltaAccel = normalize(corr_deltaAccel);

        current_attitude = sign(parts(current_attitude))*current_attitude;
        current_attitude = normalize(current_attitude);
        orientation(idx,:) = current_attitude;
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


%3D curve
figure
plot3(orientationEuler(:,1),orientationEuler(:,2),orientationEuler(:,3))
legend('Z-axis','Y-axis','X-axis')
xlabel('Time (s)')
ylabel('Rotation (degrees)')
title('Estimated Orientation')

figure
plot3(orientationEulerMatlab(:,1),orientationEulerMatlab(:,2),orientationEulerMatlab(:,3))
legend('Z-axis','Y-axis','X-axis')
xlabel('Time (s)')
ylabel('Rotation (degrees)')
title('Estimated Orientation')

