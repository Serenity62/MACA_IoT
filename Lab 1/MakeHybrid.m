
% Author: Abdallah S. Abdallah aua639@psu.edu
% MakeHybrid - Version: 0.1


clear;
clc;

close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = imread('./data/data/dog.bmp');
%image1 = imread('download (1).jpg');
image2 = imread('./data/data/cat.bmp');
%image2 = imread('download.jpg');

figure;imshowpair(image1, image2, 'montage');


image1double = double (image1)/255;

image2double = double (image2)/255;

im1 = rgb2gray(image1double);
im2 = rgb2gray(image2double);

[im1h, im1w] = size(im1);
[im2h, im2w] = size(im2);
 
hs = 50; % filter half-size
gaus_fil = fspecial('gaussian', hs*2+1, 10); 
%fil = fspecial('sobel'); 
 
fftsize = 1024; % should be order of 2 (for speed) and include padding


%% Applying the filters on input image (1)
im1_fft  = fft2(im1,  fftsize, fftsize);                    % 1) fft im with padding
%figure;imshow(im1_fft);
fil_fft = fft2(gaus_fil, fftsize, fftsize);                    % 2) fft fil, pad to same size as image

% figure;imshow(im1_fft);
% figure;imshow(im2_fft);

%% Multiplying in Frequency domain instead of concolution in spatial domain
im1_fil_fft = im1_fft .* fil_fft;                           % 3) multiply fft images
% figure;imshow(im1_fil_fft);
im1_fil = ifft2(im1_fil_fft);                               % 4) inverse fft2
im1_fil = im1_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding

% figure;imshow(im1_fil);

%% Repeat the previous work using different filter (sobel)

sob_fil = fspecial('sobel'); 

sob_fil_fft = fft2(sob_fil, fftsize, fftsize);  % FFT FILL
 
%% Repeat the implementation steps above on input image (2)

im2_fft = fft2(im2, fftsize, fftsize);      % padding
im2_fil_fft = im2_fft .* sob_fil_fft;       % MULTIPLY FFT IMAGES

% figure;imshow(im2_fil_fft);

im2_fil = ifft2(im2_fil_fft);                               % 4) inverse fft2
im2_fil = im2_fil(1+hs:size(im2,1)+hs, 1+hs:size(im2, 2)+hs); % 5) remove padding
% figure;imshowpair(im1_fil, im2_fil, 'montage');


% im1_fil = ifft2(multImage);                               % 4) inverse fft2
% im1_fil = im1_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding
% % figure;imshow(im1_fil)
% figure;imshow(im1_fil_fft);
%figure;imshow(im2_fil_fft);
% figure;imshowpair(im1_fil, im2_fil, 'montage');







%% your Algorithm below should implement the following steps
% 1) Apply FFT on image 1 , then extract the output of low pass filter and name it as out1
% 2) Apply FFT on image 2, then extract the ooutput of high pass filter and name it out2
% 3) mix  out1 and out2
% 4) Transform back to spatial intensity domain and display the final outcome


% low pass filter

% kernel_low = [1/16 1/8 1/16;
%             1/8 1/4 1/8; 
%             1/16 1/8 1/16];
% 
% % high pass filter (sharpenning)
% kernel_high = [0 -1 0; 
%            -1 5 -1;
%            0 -1 0];

       
figure; imshow(im1_fft);
figure; imshow(im2_fft);
shift1 = fftshift(im1_fft);
shift2 = fftshift(im2_fft);

% im1_fft;
% im1_fil_fft;
figure; imshow(shift1); 
figure; imshow(shift2);      
% Create blank out1   
im1_size = size(shift1);
% out1 = shift1;
out1=zeros(size(shift1));
% for i = 1: im1_size(2)
%     for j =  1: im1_size(1)
%         out1(i, j) = 0;
%     end
% end


% Copy over the center image
r = im1_size(2)*0.05;
for i = -r : r
    x = sqrt(r*r - i*i);
    for j =  -x : x
        out1(uint16(im1_size(2)/2 +i), uint16(im1_size(1)/2+j)) = shift1(uint16(im1_size(2)/2 +i),  uint16(im1_size(1)/2+j));
    end
end
% figure;imshow(out1);
% out3 = ifft2(out1);
% out3 = out3(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs);
% figure;imshow(out3);

% Black out the center
im2_size = size(shift2);
out2 = shift2;
r = im2_size(2)*0.05;
for i = -r : r
    x = sqrt(r*r - i*i);
    for j =  -x : x
        out2(uint16(im2_size(2)/2 +i), uint16(im2_size(1)/2+j)) = 0;
    end
end

figure; imshow(out1);
figure; imshow(out2);

% Multiply images
multImage = out1 + out2;
% figure(1), imagesc(log(abs(fftshift(multImage)))), axis image, colormap jet;

figure;imshow(multImage);
im_fil = ifft2(multImage);                                   % 4) inverse fft2
out3 = im_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs);  % 5) remove padding

figure;imshow(out3)
