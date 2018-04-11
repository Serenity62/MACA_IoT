% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski

detector = vision.ForegroundDetector('NumTrainingFrames', 200);
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
cam = webcam(3);

%% Train GMM
for i = 1 : 200
    im = snapshot(cam);
    frame = rgb2gray(im);    
    frameFilter = filter2(fspecial('average',2),frame)/255;
    step(detector, frameFilter);
    pause(0.005);
end
%% Preprocessing (Image Processing and Feature Extraction)
while true

    % Recieve New Frame From Webcam
    im = snapshot(cam);
    frame = rgb2gray(im);

    % Non-linear Filter for Noise Reduction
    frameFilter = filter2(fspecial('average',2),frame)/255;
%     figure;
%     imshow(frameFilter);

    % Gaussian Mixture Model for clustering image
    mask = step(detector, frameFilter);
    frameGMM = mask .* frameFilter;
%     figure;
%     imshow(frameGMM);

    % Use Canny Edge Detection Algorithm to generate binary file with edges
    frameCannyEdge = edge(frameGMM,'Canny');
%     figure;
%     imshow(frameCannyEdge);

    % Show final
    step(videoPlayer,frameCannyEdge);
end
release(videoPlayer);
release(detector);
clear cam;