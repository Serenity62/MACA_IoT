
% Author(s): Aaron Barraclough, Michael Ferry, Steven Roote, Corey Zalewski

%% Preprocessing (Image Processing and Feature Extraction)

% Recieve New Frame From Webcam
% INSERT CODE HERE

% Non-linear Filter for Noise Reduction
%frameFilter = INSERT CODE HERE

% Gaussian Mixture Model for clustering image
%frameGMM = INSERT CODE HERE

% Use Canny Edge Detection Algorithm to generate binary file with edges
frameCannyEdge = edge(frameGMM,'Canny');