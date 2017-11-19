% read the image and view it
img = imread('./images/62096.jpg');
subplot(1,3,1); imagesc(img); axis image

% extract features (stepsize = 7)
[X, L] = getfeatures(img, 7);
XX = [X(1:2,:) ; X(3:4,:)/10]; 

% initial miu & sigma & pi
K = 10;
[init_miu,init_pi,init_sigma] = init(XX,K);
% Run k-means
Y = em_segImage(XX,K,init_miu,init_sigma,init_pi); 

% make a segmentation image from the labels
segm = labels2segm(Y, L);
subplot(1,3,2); imagesc(segm); axis image;

% color the segmentation image
csegm = colorsegm(segm, img);
subplot(1,3,3); imagesc(csegm); axis image