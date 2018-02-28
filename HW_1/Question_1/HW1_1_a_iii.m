%%HW1.1.a.iii.
clc;
clear;
close all;

tic;
%Import images from HW1 folder and convert to grayscale
image1 = rgb2gray(imread('dog.bmp'));
image2 = rgb2gray(imread('motorcycle.bmp'));
image3 = rgb2gray(imread('submarine.bmp'));

%Take two-dimensional discrete Fourier Transform
%Purpose: To put the imported images in the frequency domain...
%so that we can seperate the phase from the domain 
f_im1 = fft2(image1);
f_im2 = fft2(image2);
f_im3 = fft2(image3);

%This takes the magnitudes from the frequency of the images
fmag_im1 = abs(f_im1);
fmag_im2 = abs(f_im2);
fmag_im3 = abs(f_im3);

%This takes the inverse Fourier Transform and then shifts
mag_im1 = fftshift(ifft2(fmag_im1));
mag_im2 = fftshift(ifft2(fmag_im2));
mag_im3 = fftshift(ifft2(fmag_im3));
toc;
%Shows results of magnitude of each image
% figure; imshow(uint8(mag_im1)); title('Magnitude of Dog');
% figure; imshow(uint8(mag_im2)); title('Magnitude of Motorcycle');
% figure; imshow(uint8(mag_im3)); title('Magnitude of Submarine');