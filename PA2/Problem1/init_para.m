function init_miu = init_para(X,p)
% init_para
% for initial values of Zi or parameters
% to start the algorithm

[~,n] = size(X);

%% if p=K(# of clusters)
if numel(p) == 1  % p is a scalar
    init_miu = X(:,randperm(n,p));  % pick d*K values as init_miu from X at
                                      ...random 
    
end

