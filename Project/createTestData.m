clc;
close all
clear;

filename = '_rgb.png';
path = 'Project_pictures/P';
cnt = 1;
% detector = vision.ForegroundDetector('NumTrainingFrames', 140, 'MinimumBackgroundRatio', .8);
% for i = 1 : 14
%     j = 1;
%     for k = 1 : 10
%         s = strcat(path,num2str(i),'/G',num2str(j),'/',num2str(k),filename);
%         im = imread(s);
%         tenth = imresize(im, 0.1);
%         frame = rgb2gray(tenth);
%         mask = step(detector,frame);
%     end
% end

% save('det.mat', 'detector'); % Only save the trained GMM
tic;
for i = 1 : 14 % Per Person
    detector = vision.ForegroundDetector('NumTrainingFrames', 10, 'MinimumBackgroundRatio', .95);
    for j = 1 : 10 % Per Gesture
        for k = 1 : 10 % Per Attempt
            s = strcat(path,num2str(i),'/G',num2str(j),'/',num2str(k),filename);
            im = imread(s);
            tenth = imresize(im, 0.1);
            frame = rgb2gray(tenth);
            mask = step(detector,frame);
            if j ~= 1
                frameGMM = uint8(mask) .* frame;
                frameCannyEdge = edge(frameGMM,'Canny');
                sz = size(frameCannyEdge);
                prep = reshape(frameCannyEdge, [1,sz(1)*sz(2)]);
                train(cnt, :) = prep;
                if j == 6
                    label(cnt) = 1; % On
                elseif j == 7
                    label(cnt) = 2; % Off
                else
                    label(cnt) = 0; % Nothing
                end
                cnt = cnt + 1;
                release(detector);
                load('det.mat');
            else
                if k == 10
                    save('det.mat', 'detector'); % Only save the trained GMM
                end
            end
            
        end
    end
    release(detector);
end
toc;
tic;
save('traindat.mat','train','label');
toc;
for m = 1 : 13
    testim = reshape(train(90*m,:),sz);
    testim2 = reshape(train(90*m + 10,:),sz);
    figure;
    imshowpair(testim,testim2,'montage');
end
