function [init_miu,init_pi,init_sigma] = init_theta(X,k,m)
% Input: 
%   X: d x n data matrix
%   k: the number of cluster k
%   m: the type of data (1--A,2--B,3--C)
% initial the theta using k-mean
[d,n] = size(X);
[zi,~,init_miu] = k_means(X,k,m);
init_sigma = zeros(d,d,k);
init_pi = zeros(1,k);
for j1=1:k
    labels = find(zi == j1);
    Xj = X(:,labels);
    init_pi(j1) = size(Xj,2)/n;
    init_sigma(:,:,j1) = cov(Xj');
end
end

