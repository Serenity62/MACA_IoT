clc;
close all
clear;

%% Import Training data
load('traindat.mat');
% for i = 1 : 1400
%     frame = reshape(csv(i,:), [960, 1280]);
%     fr = imresize(frame, [480,640]);
%     tr(i, :) = reshape(fr, [1,480*640]);
% end

%% Setup NN
n = size(ims, 1);                    % number of samples in the dataset
targets  = label; 
targets(targets == 0) = 3;         % use '7' to present '0'
targetsd = dummyvar(targets);       % convert label into a dummy variable

% No need for the first column in the (tr) set any longer
inputs = train;               % the rest of columns are predictors

inputs = inputs';                   % transpose input
targets = targets';                 % transpose target
targetsd = targetsd';               % transpose dummy variable

%% partitioning the dataset based on random selection of indices
rng(1);                             % for reproducibility
patitionObject = cvpartition(n,'Holdout',int8(n/3.0));   % hold out 1/3 of the dataset

Xtrain = inputs(:, training(patitionObject));    % 2/3 of the input for training
Ytrain = targetsd(:, training(patitionObject));  % 2/3 of the target for training

Xtest = inputs(:, test(patitionObject));         % 1/3 of the input for testing
Ytest = targets(test(patitionObject));           % 1/3 of the target for testing
Ytestd = targetsd(:, test(patitionObject));      % 1/3 of the dummy variable for testing

clear ims;
%% Sweep Code Block
%Sweeping to choose different sizes for the hidden layer

sweep = [100,200:100:12200];                 % parameter values to test
scores = zeros(length(sweep), length(sweep));       % pre-allocation
% we will use models to save the several neural network result from this
% sweep and run loop
models = cell(length(sweep), length(sweep));        % pre-allocation
x = Xtrain;                             % inputs
t = Ytrain;                             % targets
trainFcn = 'trainscg';                  % scaled conjugate gradient
for i = 1:length(sweep)

    hiddenLayerSize = sweep(i);         % number of hidden layer neurons
    net = patternnet(hiddenLayerSize);  % pattern recognition network
    net.divideParam.trainRatio = 70/100;% 70% of data for training
    net.divideParam.valRatio = 15/100;  % 15% of data for validation
    net.divideParam.testRatio = 15/100; % 15% of data for testing
    net = train(net, x, t);             % train the network
    models{i} = net;                    % store the trained network
    p = net(Xtest);                     % predictions
    [~, p] = max(p);                    % predicted labels
    scores(i) = sum(Ytest' == p) /length(Ytest);  % categorization accuracy

end
% Let's now plot how the categorization accuracy changes versus number of 
% neurons in the hidden layer.
figure;
plot(sweep, scores)
xlabel('number of hidden neurons')
ylabel('categorization accuracy')
title('Number of hidden neurons vs. accuracy')