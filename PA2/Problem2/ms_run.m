% read the image and view it
img = imread('./images/310007.jpg');
subplot(1,3,1); imagesc(img); axis image

% extract features (stepsize = 7)
[X, L] = getfeatures(img, 7);
XX = [X(1:2,:) ; X(3:4,:)/10]; 
% reverse row_3 and row_4
XX([3,4],:)=XX([4,3],:); % be changed to x=[u,v,cx,cy]

%{
% Run Mean-shift -- question a
hc=3;
hp=2;
h=21;
[Y,C] = ms_segImage(XX,hc,hp,h); 
%}

% Run Mean_shift -- question b
hc1=3;
hc2=4;
hp1=8;
hp2=6;
h=10;
[Y,C] = ms_segImage(XX,hc,hp,h); 
% make a segmentation image from the labels
segm = labels2segm(Y, L);
subplot(1,3,2); imagesc(segm); axis image;

% color the segmentation image
csegm = colorsegm(segm, img);
subplot(1,3,3); imagesc(csegm); axis image