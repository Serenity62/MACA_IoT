
% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski

%% Preprocessing (Image Processing and Feature Extraction)

% Recieve New Frame From Webcam
% INSERT CODE HERE

% Non-linear Filter for Noise Reduction
frameFilter = filter2(fspecial('average',2),frame)/255;

% Gaussian Mixture Model for clustering image
frameGMM = gmdistribution(frameFilter, 'full');

% Use Canny Edge Detection Algorithm to generate binary file with edges
frameCannyEdge = edge(frameGMM,'Canny');
