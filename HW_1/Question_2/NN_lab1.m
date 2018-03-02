% Gathered and edited by  Abdallah S. Abdallah aua639@psu.edu
% based on the tutorial at https://blogs.mathworks.com/loren/2015/08/04/artificial-neural-networks-for-beginners/#1168dbb4-1365-4b63-8326-140263e2072f


clear;
clc;

close all; % closes all figures


%% data formatting
trainsize = 15000; testsize = 5000; maxsize = 15000;
[numdat, textdat] = xlsread('fer2013.csv');
% testdata = textdat(0:trainsize, 2);

% a = cellfun(@(x)regexp(x,' ','split'),textdat(:,2),'UniformOutput',0);
tr = uint8(zeros(trainsize, 48*48+1));
for i = 2:trainsize + 1
    s = char(textdat(i,2));
    c = strsplit(s, ' ');
    m = uint8(str2double(c));
    tr(i-1,2:48*48+1) = m;
end
sub = uint8(zeros(testsize, 48*48+1));
for i = 2 : testsize + 1
    s = char(textdat(i+trainsize,2));
    c = strsplit(s, ' ');
    m = uint8(str2double(c));
    sub(i-1,2:48*48+1) = m;
end
% y = numdat(1:trainsize-1,1);
% x = vertcat(numdat(1:trainsize,1), tr);

tr(:,1) = numdat(1:trainsize,1);
sub(:,1) = numdat(trainsize+1:maxsize,1);

% im = reshape(textdat(2,2), [48,48]);


% The first column is the label that shows the correct digit for each sample in the dataset,
% and each row is a sample. In the remaining columns, a row represents a 28 x 28 image of a
% handwritten digit, but all pixels are placed in a single row, rather than in the
% original rectangular form. To visualize the digits, we need to reshape the rows
% into 28 x 28 matrices. You can use reshape for that, except that we need to transpose the 
% data, because  reshape operates by column-wise rather than row-wise.

% The training set is 28,000 samples
% testing set is 42000 samples
figure    ;                                      % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(tr(i, 2:end), [48,48])';    % row = 28 x 28 image
    imagesc(digit)                              % show the image
    title(num2str(tr(i, 1)))                    % show the label
end


%% The labels range from 0 to 9, but we will use '10' to represent '0' because MATLAB is indexing is 1-based.

% 1 --> [1; 0; 0; 0; 0; 0; 0; 0; 0; 0]
% 2 --> [0; 1; 0; 0; 0; 0; 0; 0; 0; 0]
% 3 --> [0; 0; 1; 0; 0; 0; 0; 0; 0; 0]
%             :
% 0 --> [0; 0; 0; 0; 0; 0; 0; 0; 0; 1]
% The dataset stores samples in rows rather than in columns, so you need to
% transpose it. Then you will partition the data so that you hold out 1/3 of the data
% for model evaluation, and you will only use 2/3 for training our artificial neural network model.

n = size(tr, 1);                    % number of samples in the dataset
targets  = double(tr(:,1));                 % 1st column is |label|
targets(targets == 0) = 7;         % use '10' to present '0'
targetsd = dummyvar(targets);       % convert label into a dummy variable
inputs = tr(:,2:end);               % the rest of columns are predictors

inputs = inputs';                   % transpose input
targets = targets';                 % transpose target
targetsd = targetsd';               % transpose dummy variable

%% partitioning the dataset based on random selection of indices
rng(1);                             % for reproducibility
c = cvpartition(n,'Holdout',uint8(n/3));   % hold out 1/3 of the dataset

Xtrain = inputs(:, training(c));    % 2/3 of the input for training
Ytrain = targetsd(:, training(c));  % 2/3 of the target for training
Xtest = inputs(:, test(c));         % 1/3 of the input for testing
Ytest = targets(test(c));           % 1/3 of the target for testing
Ytestd = targetsd(:, test(c));      % 1/3 of the dummy variable for testing
Xtrain = double(Xtrain);
Xtest = double(Xtest);
Ytest = double(Ytest);

% Visualizing the Learned Weights
% If you look inside myNNfun.m, you see variables like IW1_1 and x1_step1_keep 
% that represent the weights your artificial neural network model learned through training.
% Because we have 784 inputs and 100 neurons, the full layer 1 weights will be a 100 x 784 matrix.
% Let's visualize them. This is what our neurons are learning!
% load myWeights                          % load the learned weights
% W1 =zeros(100, 28*28);                  % pre-allocation
% W1(:, x1_step1_keep) = IW1_1;           % reconstruct the full matrix
% figure                                  % plot images
% colormap(gray)                          % set to grayscale
% for i = 1:25                            % preview first 25 samples
%     subplot(5,5,i)                      % plot them in 6 x 6 grid
%     digit = reshape(W1(i,:), [28,28])'; % row = 28 x 28 image
%     imagesc(digit)                      % show the image
% end


%% Computing the Categorization Accuracy
% Now you are ready to use myNNfun.m to predict labels for the heldout data in Xtest and 
% compare them to the actual labels in Ytest. That gives you a realistic predictive performance against unseen data. This is also the metric Kaggle uses to score submissions.
% 
% First, you see the actual output from the network, which shows the probability 
% for each possible label. You simply choose the most probable label as your prediction 
%     and then compare it to the actual label. You should see 95% categorization accuracy.

Ypred = myNNfun(Xtest);             % predicts probability for each label
Ypred(:, 1:5)                       % display the first 5 columns
[~, Ypred] = max(Ypred);            % find the indices of max probabilities
sum(Ytest == Ypred) / length(Ytest) % compare the predicted vs. actual


% You probably noticed that the artificial neural network model generated from 
% the Pattern Recognition Tool has only one hidden layer. You can build a custom
% model with more layers if you would like, but this simple architecture is sufficient
% for most common problems.
% 
% The next question you may ask is how I picked 100 for the number of hidden neurons.
% The general rule of thumb is to pick a number between the number of input neurons,
% 784 and the number of output neurons, 10, and I just picked 100 arbitrarily. 
% That means you might do better if you try other values. 
% Let's do this programmatically this time. myNNscript.m will be handy for this
% - you can simply adapt the script to do a parameter sweep.

sweep = [500,600:100:1200];                 % parameter values to test
scores = zeros(length(sweep), 1);       % pre-allocation
models = cell(length(sweep), 1);        % pre-allocation
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
    scores(i) = sum(Ytest == p) /...    % categorization accuracy
        length(Ytest);
end
% Let's now plot how the categorization accuracy changes versus number of 
% neurons in the hidden layer.

figure
plot(sweep, scores, '.-')
xlabel('number of hidden neurons')
ylabel('categorization accuracy')
title('Number of hidden neurons vs. accuracy')

