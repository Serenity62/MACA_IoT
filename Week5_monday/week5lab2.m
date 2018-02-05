% Author: Abdallah S. Abdallah aua639@psu.edu


clear;
clc;

close all; % closes all figures

%% Setup
original = imread('data/dog.bmp');
image1_gray= rgb2gray(original);
figure;imshow(image1_gray);

Smp1 = imresize(image1_gray, 2, 'nearest');
Smp2 = imresize(image1_gray, 2, 'bilinear');
Smp3 = imresize(image1_gray, 2, 'bicubic');

smp1 = edge(Smp1, 'canny');
smp2 = edge(Smp2, 'canny');
smp3 = edge(Smp3, 'canny');
figure;imshow(smp3);

se = strel('disk',10);
s1=imclose(smp1, se);
s2=imclose(smp2, se);
s3=imclose(smp3, se);

figure;imshow(s1);
figure;imshow(s2);
figure;imshow(s3);

s2=imfill(s2, 'holes');

f= Smp2.*uint8(s2);
figure;imshow(f);


%dilateBW = imdilate(originalBW,se);
%figure, imshow(dilateBW);title('dilateBW');


%erodeBW = imerode(originalBW,se);
%figure, imshow(erodeBW); title('erodeBW');


%openBW = imopen(originalBW,se);
%figure, imshow(openBW); title('openBW');


%closeBW = imclose(originalBW,se);
%figure, imshow(closeBW); title('closeBW');

%% Using SE = strel('square',W)
% disp('hit any key to continue');
% pause;
% 
% se = strel('square',10);
% dilateBW = imdilate(originalBW,se);
% figure, imshow(dilateBW);title('dilateBW');
% 
% 
% erodeBW = imerode(originalBW,se);
% figure, imshow(erodeBW); title('erodeBW');
% 
% 
% openBW = imopen(originalBW,se);
% figure, imshow(openBW); title('openBW');
% 
% 
% closeBW = imclose(originalBW,se);
% figure, imshow(closeBW); title('closeBW');
