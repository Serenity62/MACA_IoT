clc;
close all
clear;

filename = '_rgb.png';
path = 'Project_pictures/P';
cnt = 1;
W = 248;
H = 229;

tic;
t = [1 3 8];
for i = t % Per Person (Person 14 and 13 is not well lit)
    for j = 1 : 10 % Per Gesture
        for k = 1 : 10 % Per Attempt
            if j == 6 || j == 7 || (k == 2 || ((j == 1 || j==2) && k == 1))
                s = strcat(path,num2str(i),'/G',num2str(j),'/',num2str(k),filename);
                im = imread(s);
                % Prepross
                prep = preprocess(im);
                sz = size(prep);
                %szs(cnt,:) = sz;
                %ims(cnt,:) = reshape(prep,[1 ,sz(1)*sz(2)]);
                sumCol(cnt,:) = prep;
                %sumRow(cnt,:) = prep(2);
                if j == 6
                    tmp = 1;
                elseif j == 7
                    tmp = 2;
                else
                    tmp = 0;
                end
                label(cnt) = tmp;
                cnt = cnt + 1;
            end
        end
    end
end
toc;
% maxHieght = max(szs(1));
% maxWidth = max(szs(2));

tic;
save('traindat.mat','sumCol','label');
toc;

% for m = 0 : 11
%     testim = reshape(ims(100*m +1,:),sz);
%     testim2 = reshape(ims(100*m + 10,:),sz);
%     figure;
%     imshowpair(testim,testim2,'montage');
% end
% 
% figure;
% imshow(im);
% figure;
% imshow(prep);