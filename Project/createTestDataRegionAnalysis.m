clc;
close all
clear;


%% Load Data
im = imread('1_rgb.png');

%% Apply Skin Segmentation Algorithm (Loop with pixel RGBm conditions)

mask = im(:,:,1);
for i = 1 : 960
    for j = 1 : 1280
        % Get pixel
        r = im(i,j,1);
        g = im(i,j,2);
        b = im(i,j,3);
        
        if r > 95 && g > 40 && b > 20 && ((max([r, g, b])-min([r, g, b]))>15) && (abs(r -g)>15) && (r>g) && (r > b)
            mask(i,j) = 1;
        else
            mask(i,j) = 0;
        end
    end
end

%% Open Image

%se = strel('disk',1);
%maskOpened = imopen(mask, se);

%maskL = logical(maskOpened);
%figure;
%imshow(maskL);

%% Run Image Regional Analysis

maskLogical = logical(mask);

%figure;
%imshow(maskLogical);

stats = regionprops(maskLogical, 'Area', 'PixelIdxList', 'BoundingBox');

%% Find Largest Region by Area
[maxValue, Index] = max([stats.Area]);


%% Find Minumum Box to Enclose Area

%% Crop Area

%% Canny Edge Detector