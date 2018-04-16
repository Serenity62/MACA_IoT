clc;
clear;
close all;

im = imread('Project_pictures\P1\G1\1_rgb.png');
mask = im(:,:,1);
for i = 1 : 960
    for j = 1 : 1280
        % Get pixel
        r = im(i,j,1);
        g = im(i,j,2);
        b = im(i,j,3);
        
        if r > 95 && g > 40 && b > 20 && ((max([r, g, b])-min([r, g, b]))>15) && (abs(r -g)>15) && (r>g) && (r > b)
            mask(i,j) = 1;
        else
            mask(i,j) = 0;
        end
    end
end

gray = rgb2gray(im);
out = im .* mask;
figure;
imshow(out);

