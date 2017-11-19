
% Just for testing

img = imread('./images/12003.jpg');
subplot(1,3,1); imagesc(img); axis image

[X, L] = getfeatures(img, 7);
XX = [X(1:2,:) ; X(3:4,:)/10]; 