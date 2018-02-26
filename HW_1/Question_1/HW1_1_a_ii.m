%HW1.1.a.ii.
clc;
clear;
close all;

tic;
%Import images from HW1 folder and convert to grayscale
image1 = rgb2gray(imread('dog.bmp'));
image2 = rgb2gray(imread('einstein.bmp'));
image3 = rgb2gray(imread('fish.bmp'));

%Take two-dimensional discrete Fourier Transform
%Purpose: To put the imported images in the frequency domain...
%so that we can seperate the phase from the domain 
f_im1 = fft2(image1);
f_im2 = fft2(image2);
f_im3 = fft2(image3);

%This takes the phase angle from the frequency of the images
%supports double
fph_im1 = angle(double(f_im1));
fph_im2 = angle(double(f_im2));
fph_im3 = angle(double(f_im3));

%Puts the phase into the part of vector notation we need
%Then takes the two-dimensional inverse discrete Fourier transform
ph_im1 = ifft2(exp(1i*fph_im1));
ph_im2 = ifft2(exp(1i*fph_im2));
ph_im3 = ifft2(exp(1i*fph_im3));

%Displays images phase components where the magnitude is neutralized(=1)
%The square brackets after the ph_im just allows the image to be displayed
%on range of pixal values in the image, so the image is not just black
% figure; imshow(ph_im1,[]); title('Phase of dog');
% figure; imshow(ph_im2,[]); title('Phase of Einstein');
% figure; imshow(ph_im3,[]); title('Phase of fish');
toc;