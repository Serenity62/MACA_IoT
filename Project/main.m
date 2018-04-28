% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski
clc;
clear;
close all;
%% Setup
mypi = raspi('192.168.110.154','pi','raspberry');
% videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
cam = webcam(mypi,char(mypi.AvailableWebcams(1)), '640x480');
% cam.Resolution = '640x480'; /dev/video0 or HD Webcam C615 (usb-3f980000.usb-1.3):
load('nn.mat'); %bestNN is the name for the nn
im = snapshot(cam);
prv = 0;

%% Preprocessing (Image Processing and Feature Extraction)
while true

    % Recieve New Frame From Webcam
    im = snapshot(cam);
    %frame = rgb2gray(im);
    
    % preprocessing
    frameCannyEdge=preprocess(im);
    
%     figure;
%     imshow(frameCannyEdge);
    
    % Canny Edge into feature vector
    sz = size(frameCannyEdge); %size of CannyEdge frame
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
%     p = gpu2nndata(p);
    
    % Feed prediction to API caller
    if prv ~= p
        prv = p;
        API_caller(p);
    end
    disp(p);
    pause(.5);
    % Show final
%     step(videoPlayer,frameCannyEdge);
end
% release(videoPlayer);
clear cam;