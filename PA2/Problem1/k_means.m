function [labels,indicator,miu] = k_means(X,K,m)
% Perform k-means clustering.
% Input:
%   X: d x n data matrix
%   K: # of clusters
%   m: choice of initialization of miu (1-dataA, 2-dataB, 3-dataC)
% Output:
%   labels(yi): 1 x n sample labels(Y=[y1,y2,...,yn])
%   miu: d x k center of clusters
fprintf('K-Mean Algorithm: running ... \n');
[d,n] = size(X);

% initial miu 
%miu = init_para(X,K);
% 1 -- dataA
if m == 1
    miu = zeros(d,K);
    miu(:,1)=[10,-10];
    miu(:,2)=[-10,-10];
    miu(:,3)=[-10,10];
    miu(:,4)=[10,10];
end
% 2 -- dataB
if m == 2
    miu = zeros(d,K);
    miu(:,1)=[-5,0];
    miu(:,2)=[-1,0];
    miu(:,3)=[1,0];
    miu(:,4)=[5,0];
end
% 3 -- dataC
if m == 3
    miu = zeros(d,K);
    miu(:,1)=[-10,0];
    miu(:,2)=[-1,0];
    miu(:,3)=[1,0];
    miu(:,4)=[10,0];
end

% yij is a row vector of indicator
% yi is lables
yij = zeros(1,n);
yi = zeros(1,n);

while true
    old_miu = miu;
    for k = 1:K
        [yi, yij, miu] = iter_process(X,K,miu,k,yi,yij);
    end
    if norm(miu-old_miu)<0.01
        break
    end
end
labels=yi;
indicator = yij;
fprintf('K-Mean Algorithm: Finished! \n');
end

%% One round process
function [yi,yij,miu] = iter_process(X,K,miu,k,yi,yij) 
[d,n] = size(X);
% ==== Calculate the new yij ====
for ii=1:n
    dis = zeros(1,K); % initial the container of distance 
    for mm = 1:K
        % Calculate the distance betweem xi and each miu of 4 cluster
        dis(1,mm) = dot((X(:,ii)-miu(:,mm)),(X(:,ii)-miu(:,mm))); 
    end
    % Pick the shortest distance
    kk = find(dis == min(dis));
    % Put the new shortest distance into the lables(yi)
    yi(1,ii) = kk;
    if kk == k % kk == cluster k ???
        yij(1,ii) = 1;
    else
        yij(1,ii) = 0;
    end
end
 % ==== Calculate the new miu ====
sum_yij = 0;
sum_yx = zeros(d,1);
for ij = 1 : n 
    sum_yij = sum_yij + yij(1,ij);
    sum_yx = sum_yx + yij(ij) * X(:,ij);
end
% the miu_k is the new center of the cluster k
miu_k = sum_yx / sum_yij;
% update the old miu with miu_k
miu(:,k) = miu_k;
end
