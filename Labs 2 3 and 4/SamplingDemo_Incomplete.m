
% Author: Abdallah S. Abdallah aua639@psu.edu
% MakeHybrid - Version: 0.1


clear;
clc;

close all; % closes all figures

%% Setup
% read images and convert to floating point format
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
figure;imshowpair(image1_gray, image2_gray, 'montage');

out1 = zeros(floor(size(image1_gray,1)/2), floor(size(image1_gray,2)/2));




% Down sampling by a factor of two
out1 = image1_gray(1:2:end, 1:2:end);


figure;imshow(out1);

%% alternative downsample method.

out11 = imresize(image1_gray,0.5);
figure;imshow(out11);

%% Class Sampling Lab1 
% Create an Upsampler with a factor of two using the imresize function
% out2 = image1_gray(2:1:end, 2:1:end);
out12 = imresize(image1_gray,2);
figure;imshow(image1_gray);
figure;imshow(out12);


%% Implement Sampling Lab2
[im1h, im1w] = size(image1_gray);
[im2h, im2w] = size(image2_gray);
[im3h, im3w] = size(image3_gray);
[im4h, im4w] = size(image4_gray);

out13 = imresize(image1_gray,[360 410]);
out14 = imresize(image2_gray,[360 410]);
out15 = imresize(image3_gray,[360 410]);
out16 = imresize(image4_gray,[360 410]);

out_mat = [out14 out15; out16 out13];
figure; imshow(out_mat);
%% Implement Sampling Lab3

outn1 = imresize(image1_gray,[360 410],'nearest');
outn2 = imresize(image2_gray,[360 410],'nearest');
outn3 = imresize(image3_gray,[360 410],'nearest');
outn4 = imresize(image4_gray,[360 410],'nearest');

out_n = [outn2 outn3; outn4 outn1];
% figure; imshow(out_n);



outn1 = imresize(image1_gray,[360 410],'bilinear');
outn2 = imresize(image2_gray,[360 410],'bilinear'); % We thought was the best method. Made picture clearer and crisper
outn3 = imresize(image3_gray,[360 410],'bilinear');
outn4 = imresize(image4_gray,[360 410],'bilinear');

out_b = [outn2 outn3; outn4 outn1];
% figure; imshow(out_b);



outn1 = imresize(image1_gray,[360 410],'bicubic');
outn2 = imresize(image2_gray,[360 410],'bicubic');
outn3 = imresize(image3_gray,[360 410],'bicubic');
outn4 = imresize(image4_gray,[360 410],'bicubic');

out_c = [outn2 outn3; outn4 outn1];
% figure; imshow(out_c);

imfft0 = fft2(out_mat);
imfft1 = fft2(out_n);
imfft2 = fft2(out_b);
imfft3 = fft2(out_c);

shift0 = fftshift(log(1+abs(imfft0)));
 % Compute the thresholds
      thresh = multithresh(shift0,2);
  
      % Apply the thresholds to obtain segmented image
      seg_I = imquantize(shift0,thresh);
  
      % Show the various segments in the segmented image in color
      RGB = label2rgb(seg_I);
      figure, imshow(RGB)

shift1 = fftshift(log(1+abs(imfft1)));
 % Compute the thresholds
      thresh = multithresh(shift1,2);
  
      % Apply the thresholds to obtain segmented image
      seg_I = imquantize(shift1,thresh);
  
      % Show the various segments in the segmented image in color
      RGB = label2rgb(seg_I);
      figure, imshow(RGB)




shift2 = fftshift(log(1+abs(imfft2)));
 % Compute the thresholds
      thresh = multithresh(shift2,2);
  
      % Apply the thresholds to obtain segmented image
      seg_I = imquantize(shift2,thresh);
  
      % Show the various segments in the segmented image in color
      RGB = label2rgb(seg_I);
      figure, imshow(RGB)

shift3 = fftshift(log(1+abs(imfft3)));

 % Compute the thresholds
      thresh = multithresh(shift3,2);
  
      % Apply the thresholds to obtain segmented image
      seg_I = imquantize(shift3,thresh);
  
      % Show the various segments in the segmented image in color
      RGB = label2rgb(seg_I);
      figure, imshow(RGB)

% figure; imshow(shift1);
% figure; imshow(shift2);
% figure; imshow(shift3);
% figure; imshow(abs(shift3-shift1));
% diff = abs(shift2-shift3);



% lab 4
close all;

up1 = imresize(image1_gray, 2, 'nearest');
up2 = imresize(image1_gray, 2, 'bilinear'); % We thought was the best method. Made picture clearer and crisper
up3 = imresize(image1_gray, 2, 'bicubic');
cup1 = edge(up1, 'canny');
cup2 = edge(up2, 'canny');
cup3 = edge(up3, 'canny');
figure;imshow(cup1);
figure;imshow(cup2);
figure;imshow(cup3);
