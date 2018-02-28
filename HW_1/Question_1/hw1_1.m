close all;
clear all;
clc;

%convert images to grayscale
image = rgb2gray(imread('fish.bmp'));
image2 = rgb2gray(imread('motorcycle.bmp'));

%get images' magnitude and phase
[Gmag, Gdir] = imgradient(image);
[Gmag2, Gdir2] = imgradient(image2);

%get sizes of images
[im2mh, im2mw] = size(Gmag2);
[im2ph, im2pw] = size(Gdir2);

%resize image for use
Gmag = imresize(Gmag, [im2ph, im2pw]);

%combine fish magnitude and motorcycle phase
imagefinal = Gmag + Gdir2;
figure;imshow(imagefinal);

%resize image for use
Gdir = imresize(Gdir, [im2mh, im2mw]);

%combine motorcycle magnitude and fish phase
imagefinal = Gdir + Gmag2;
figure;imshow(imagefinal);