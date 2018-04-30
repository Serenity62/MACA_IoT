% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski
clc;
clear;
close all;

%% Setup
disp('Connecting to Raspberry Pi');
mypi = raspi('192.168.110.154','pi','raspberry');
disp('Creating Camera Object');
cam = webcam(mypi,char(mypi.AvailableWebcams(1)), '640x480');
hueIp = '192.168.110.111';
disp('Creating connection to Hue Bridge');
hueProfile = setupHue(hueIp);
load('nn.mat'); % bestNN is the name for the nn
im = snapshot(cam); % first snapshot is always black
prv = 0;

%% Preprocessing (Image Processing and Feature Extraction)
disp('Executing...');
while true

    % Recieve New Frame From Webcam
    im = snapshot(cam);
    
    % Preprocessing
    frameCannyEdge = preprocess(im);
    
    % Canny Edge into feature vector
    sz = size(frameCannyEdge);
    fv = reshape(frameCannyEdge,[1,sz(1)*sz(2)]); 
    
    % Feed feature vector to NN
    sz = size(fv);
    if sz(2) < 239  % force to input size
        tmp = zeros(239);
        tmp(1:sz(2)) = fv;
        fv = tmp;
    else            % Ensure at most 240
        fv = fv(1:239)';
    end
    p = bestNN(fv); %prediction of NN(1-10)
    [~, p] = max(p);
    
    % Feed prediction to API caller
    if prv ~= p     % Don't call if value hasn't changed.
        prv = p;
        API_caller(p, hueIp, hueProfile);
    end
    %disp(p);   % Uncomment if you want to see the predication from NN
    pause(.5);      % Small pause between capture
end
clear cam;