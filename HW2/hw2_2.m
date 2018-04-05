%%
clear;
clc;
close all; % closes all figures
%%
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
%% ToDO by students: Now continue the homework on your own, you should not 
% need more guidance
[row, col] = size(data);
tr = double(zeros(row, 29*29+1));
%tr(:,1) = data(:,1);
%do we need to copy over the column titles too???

for i = 1:row                                    % preview first 25 samples
    digit = reshape(data(i, 1:end), [48,48])';    % row = 48 x 48 image
    % Apply wave fun here
    wname = 'coif2';
    [cA,cH,cV,cD] = dwt2(digit,wname);
    % Convert back to 2D
    V = reshape(cV, [1,29*29]);
    % Copy to new vector
    tr(i,2:29*29+1) = V;    
end

save('Coif2Data.mat','tr');

%%
tr = double(zeros(row, 33*33+1));
%tr(:,1) = data(:,1);
%do we need to copy over the column titles too???

for i = 1:row                                    % preview first 25 samples
    digit = reshape(data(i, 1:end), [48,48])';    % row = 48 x 48 image
    % Apply wave fun here
    wname = 'bior3.9';
    [cA,cH,cV,cD] = dwt2(digit,wname);
    % Convert back to 2D
    V = reshape(cV, [1,33*33]);
    % Copy to new vector
    tr(i,2:33*33+1) = V;    
end

save('BiorData.mat','tr');
%%

%% The dataset stores samples in rows rather than in columns, so you need to
% transpose it. Then you will partition the data so that you hold out 1/3 of the data
% for model evaluation, and you will only use 2/3 for training our artificial neural network model.
load('BiorData.mat');
load('emotion.mat');
sizes=[1000;800;];
for k=1:2
    n = size(emotion, 1);                    % number of samples in the dataset
    targets  = emotion(:,1);                 % 1st column is |label|
    targets(targets == 0) = 7;         % use '7' to present '0'
    targetsd = dummyvar(targets);       % convert label into a dummy variable

    % No need for the first column in the (tr) set any longer
    inputs = tr(:,:);               % the rest of columns are predictors

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

    %% Sweep Code Block
    %Sweeping to choose different sizes for the hidden layer

    sweep = [10,50:50:sizes(k)];                 % parameter values to test
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
        scores(i) = sum(Ytest == p) /length(Ytest);  % categorization accuracy
        
    end
    % Let's now plot how the categorization accuracy changes versus number of 
    % neurons in the hidden layer.
    if k==1
        figure('Name', 'Bior3.9')
    else
        figure('Name', 'Coif2')
    end
    plot(sweep, scores)
    xlabel('number of hidden neurons')
    ylabel('categorization accuracy')
    title('Number of hidden neurons vs. accuracy')
    if k==1
        clear;
        load('Coif2Data.mat');
        load('emotion.mat');
        clear Coif2Data;
        sizes=[1000;800;];
    end
end
