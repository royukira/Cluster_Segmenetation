function [Y,C] = kmean_segImage(XX,K,lamda)
% using k-mean to segment a image
% INPUT:
%       XX: d * n matrix -- d-dimensional
%       K:  # of clusters
% OUTPUT:
%       Y: lables of clusters
%       C: ?

fprintf('K-Mean Algorithm: running ... \n');
[d,n] = size(XX);
%% Initial Miu
% TODO
miu = init_para(XX,K); % Randomly choose miu
%% Run k-means
% yij is a row vector of indicator
% yi is lables
yij = zeros(1,n); % record the indicator of each point in an iter-round
yi = zeros(1,n); % record the labels of each point
while true
    old_miu = miu;
    for k = 1:K
        [yi, yij, miu] = iter_process(XX,K,miu,k,yi,yij,lamda);
    end
    if norm(miu-old_miu)<0.01
        break
    end
end
Y=yi;
fprintf('K-Mean Algorithm: Finished! \n');
end

%% One round process
function [yi,yij,miu] = iter_process(XX,K,miu,k,yi,yij,lamda) 
[d,n] = size(XX);
% ==== Calculate the new yij ====
for ii=1:n
    dis = zeros(1,K); % initial the container of distance btw cluster ki and kj
    for mm = 1:K
        % Calculate the distance betweem xxi and each miu of 4 cluster
        dis(1,mm) = (XX(1:2,ii)-miu(1:2,mm))'*(XX(1:2,ii)-miu(1:2,mm))...
                    + lamda...
                    * (XX(3:4,ii)-miu(3:4,mm))'*(XX(3:4,ii)-miu(3:4,mm));
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
    sum_yx = sum_yx + yij(ij) * XX(:,ij);
end
% the miu_k is the new center of the cluster k
miu_k = sum_yx / sum_yij;
% update the old miu with miu_k
miu(:,k) = miu_k;
end



