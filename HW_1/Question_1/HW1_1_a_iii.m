%% HW1.1.a.iii.
clc;
clear;
close all;

% Import images from HW1 folder and convert to grayscale
image1 = rgb2gray(imread('dog.bmp'));
image2 = rgb2gray(imread('motorcycle.bmp'));
image3 = rgb2gray(imread('submarine.bmp'));

% Take two-dimensional discrete Fourier Transform
% Purpose: To put the imported images in the frequency domain...
% so that we can seperate the phase from the domain 
f_im1 = fft2(image1);
f_im2 = fft2(image2);
f_im3 = fft2(image3);

% This takes the magnitudes from the frequency of the images
fmag_im1 = abs(f_im1);
fmag_im2 = abs(f_im2);
fmag_im3 = abs(f_im3);

% This takes the Inverse Fourier Transform
mag_im1 = ifft2(fmag_im1);
mag_im2 = ifft2(fmag_im2);
mag_im3 = ifft2(fmag_im3);

% This FFT Shifts the result to move origin to center
mag_im1_s = fftshift(mag_im1);
mag_im2_s = fftshift(mag_im2);
mag_im3_s = fftshift(mag_im2);

% Shows results of magnitude of each image using imshow
figure; imshow(uint8(mag_im1_s)); title('Magnitude of Dog');
figure; imshow(uint8(mag_im2_s)); title('Magnitude of Motorcycle');
figure; imshow(uint8(mag_im3_s)); title('Magnitude of Submarine');

% Shows results of magnitude using imagesc (different results)
%figure; imagesc(mag_im1_s); colormap gray; title('Magnitude of Dog');
%figure; imagesc(mag_im2_s); colormap gray; title('Magnitude of Motorcycle');
%figure; imagesc(mag_im3_s); colormap gray; title('Magnitude of Submarine');


