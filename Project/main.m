% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski
clc;
clear;
close all;

mypi = raspi('192.168.110.154','pi','raspberry');
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
cam = webcam(mypi,char(mypi.AvailableWebcams(1)), '640x480');
% cam.Resolution = '640x480'; /dev/video0 or HD Webcam C615 (usb-3f980000.usb-1.3):
load('nn.mat'); %bestNN is the name for the nn
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
    p = bestNN(datann2gpu(fv)); %prediction of NN(1-10)
    p = gpu2datann(p);
    
    % Feed prediction to API caller
%     API_caller(p);
    disp(p);
    % Show final
    step(videoPlayer,frameCannyEdge);
end
release(videoPlayer);
clear cam;