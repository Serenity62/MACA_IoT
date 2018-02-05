% Author: Abdallah S. Abdallah aua639@psu.edu


clear;
clc;

close all; % closes all figures

%% Setup
image1 = imread('./data/dog.bmp');
image2 = imread('./data/cat.bmp');
image3 = imread('./data/bird.bmp');
image4 = imread('./data/fish.bmp');

image1double = double (image1)/255;
image2double = double (image2)/255;
image3double = double (image3)/255;
image4double = double (image4)/255;

image1_gray = rgb2gray(image1);
image2_gray = rgb2gray(image2);
image3_gray = rgb2gray(image3);
image4_gray = rgb2gray(image4);

[im1h, im1w] = size(image1_gray);
[im2h, im2w] = size(image2_gray);
[im3h, im3w] = size(image3_gray);
[im4h, im4w] = size(image4_gray);

out13 = imresize(image1_gray,[360 410]);
out14 = imresize(image2_gray,[360 410]);
out15 = imresize(image3_gray,[360 410]);
out16 = imresize(image4_gray,[360 410]);

out_mat = [out14 out15; out16 out13];

Smp1 = imresize(image1_gray, 2, 'nearest');
Smp2 = imresize(out_mat, 2, 'bilinear');
Smp3 = imresize(image1_gray, 2, 'bicubic');

smp1 = edge(Smp1, 'canny');
smp2 = edge(Smp2, 'canny');
smp3 = edge(Smp3, 'canny');


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
