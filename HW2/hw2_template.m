% Author: Abdallah S. Abdallah aua639@psu.edu
% HW2_template.m - Version: 0.2


clear;
clc;
close all; % closes all figures

%% Load the dataset

% I already used Matlab GUI to generatre the function
% (importfileAsColVectors) and uploaded it to the homework folder as well
[emotion,pixels,Usage] = importfileAsColVectors('fer2013.csv',2, 35888 );
save('emotion.mat', 'emotion');
save('Usage.mat', 'Usage');
clear emotion Usage;

pixelsChars = char(pixels);
clear pixels;

tic
pixelsData_chunk1 = str2num(pixelsChars(1:10000,:));
toc
save('pixelsData_chunk1.mat', 'pixelsData_chunk1');
clear pixelsData_chunk1;

%% ToDO by students: repeat partitionin and processing until you extract all data pixels
tic
pixelsData_chunk2 = str2num(pixelsChars(10001:20000,:));
toc
save('pixelsData_chunk2.mat', 'pixelsData_chunk2');
clear pixelsData_chunk2;

tic
pixelsData_chunk3 = str2num(pixelsChars(20001:30000,:));
toc
save('pixelsData_chunk3.mat', 'pixelsData_chunk3');
clear pixelsData_chunk3;

tic
pixelsData_chunk4 = str2num(pixelsChars(30001:35887,:));
toc
save('pixelsData_chunk4.mat', 'pixelsData_chunk4');
clear pixelsData_chunk4;
clear pixelsChars;

%% ToDO by students:use matlab syntax to combine the pixels data
%% be smart and save the pixels data as well before you actually use it for
%% wavelets calculations, so that if you suffer any crashes, you never need
%% to rerun the .csv reading and parsing code again
data = double(zeros(0, 48*48));

load('pixelsData_chunk1.mat');
data = [data; pixelsData_chunk1];
clear pixelsData_chunk1;

load('pixelsData_chunk2.mat');
data = [data; pixelsData_chunk2];
clear pixelsData_chunk2;

load('pixelsData_chunk3.mat');
data = [data; pixelsData_chunk3];
clear pixelsData_chunk3;

load('pixelsData_chunk4.mat');
data = [data; pixelsData_chunk4];
clear pixelsData_chunk4;


%% ToDO by students:Loop over each row to execute
% restructure each row into 2D Image matrix
% apply wavelet analysis to level 1
% repeat wavelet analysis as you desire
% choose and combine the wavelets coefficients that you like
% concatenate the chosen subset of coefficients into single row format
[row, col] = size(data);

tr = double(zeros(row, 24*24+1));
%tr(:,1) = data(:,1);
%do we need to copy over the column titles too???

for i = 1:row                                    % preview first 25 samples
    digit = reshape(data(i, 1:end), [48,48])';    % row = 48 x 48 image
    % Apply wave fun here
    wname = 'haar';
    [cA,cH,cV,cD] = dwt2(digit,wname);
    % Convert back to 2D
    V = reshape(cV, [1,24*24]);
    % Copy to new vector
    tr(i,2:24*24+1) = V;    
end

load('emotion.mat');
clear digit;
tr(:,1) = emotion;

clear emotion;

%% ToDO by students: after loopoing , save the wavelets data structure as a preprocessed 
% dataset so that you can also use it in future without going through 
% all previous steps again
save('HaarData.mat','tr');

