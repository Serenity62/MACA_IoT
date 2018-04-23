function maskCanny = preprocess(im)

    % This will preprocess an image 'im' for use for training NN
    % Input = Image 'im'
    
    W = 247;
    H = 228;
    % Apply Skin Segmentation Algorithm (Loop with pixel RGBm conditions)
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

    % Open Image
    se = strel('disk',2);
    maskOpened = imopen(mask, se);
    maskL = logical(maskOpened);
    % Run Image Regional Analysis
    stats = regionprops(maskL, 'Area', 'PixelIdxList', 'BoundingBox');
    % Find Largest Region by Area
    [maxArea, Index] = max([stats.Area]);
    % Find Minumum Box to Enclose Area
    bounds = stats(Index).BoundingBox;
    % Adjust box
    bufx = (W - bounds(3))/2;
    bufy = (H - bounds(4))/2;
    nx1 = bounds(1)-bufx;
    nx2 = W;
    ny1 = bounds(2)-bufy;
    ny2 = H;
    bounds = [nx1; ny1; nx2; ny2];
    % Crop Area
    maskCropped = imcrop(maskL, bounds);
    % Resize
    maskCroppedResized = imresize(maskCropped, 0.5);
    % Canny Edge Detector
    maskCanny = edge(maskCroppedResized, 'Canny');
end