% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski

mypi = raspi('192.168.110.2','pi','raspberry');
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
cam = webcam(mypi);
load('nn.mat'); %bestNN is the name for the nn
%% Preprocessing (Image Processing and Feature Extraction)
while true

    % Recieve New Frame From Webcam
    im = snapshot(cam);
    frame = rgb2gray(im);
    
    % Use skin segmentation code
    
    
    % Region analysis
    
    
    % Use Canny Edge Detection Algorithm to generate binary file with edges
    frameCannyEdge = edge(frameGMM,'Canny');
%     figure;
%     imshow(frameCannyEdge);
    
    % Canny Edge into feature vector
    sz = size(frameCannyEdge); %size of CannyEdge frame
    fv = reshape(frameCannyEdge,[1,sz(1)*sz(2)]); 
    
    % Feed feature vector to NN    
    p = net(fv); %prediction of NN(1-10)
    
    % Feed prediction to API caller
    API_caller(p);
    
    
    % Show final
    step(videoPlayer,frameCannyEdge);
end
release(videoPlayer);
clear cam;