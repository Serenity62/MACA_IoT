close all;
clear all;
clc;
% Read images   
Im1 = imread('fish.bmp');
Im2 = imread('motorcycle.bmp');

%Convert to grayscale
Im1 = rgb2gray(Im1);
Im2 = rgb2gray(Im2);

% get size of images
[r1, c1] = size(Im1);
[r2, c2] = size(Im2);

rows = max(r1, r2);
cols = max(c1, c2);

% FFT
Im1_FFT=fft2(Im1, rows, cols);
Im2_FFT=fft2(Im2, rows, cols);

% get magnitudes and phase
mag1 = abs(Im1_FFT);
mag2 = abs(Im2_FFT);
pha1 = angle(Im1_FFT);
pha2 = angle(Im2_FFT);

% combine images
out1 = mag1 .* exp(1i*pha2);
out2 = mag2 .* exp(1i*pha1);

% inverse
out1 = real(ifft2(out1));
out2 = real(ifft2(out2));

% show images
figure;imshow(out1, []);
figure;imshow(out2, []);