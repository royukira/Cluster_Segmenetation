
% read the image and view it
img = imread('./images/62096.jpg');
subplot(1,3,1); imagesc(img); axis image

% extract features (stepsize = 7)
[X, L] = getfeatures(img, 7);
XX1 = [X(1:2,:) ; X(3:4,:)/10]; 
% reverse row_3 and row_4
XX1([3,4],:)=XX1([4,3],:); % be changed to x=[u,v,cx,cy]

% Run k-means
K = 10;
%Y = kmean_segImage(XX1,K,0.5); % lamda = 0.5
Y = kmean_sed(XX1,K,0.8,0.6,0.4); % lamda1 = 0.5, lamda2 =0.6 lamda3=0.4
% make a segmentation image from the labels
segm = labels2segm(Y, L);
subplot(1,3,2); imagesc(segm); axis image;

% color the segmentation image
csegm = colorsegm(segm, img);
subplot(1,3,3); imagesc(csegm); axis image