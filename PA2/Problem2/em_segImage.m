function [Y,C] = em_segImage(XX,K,init_miu,init_sigma,init_pi)
% using EM to segment a image
% INPUT:
%       XX: d * n matrix -- d-dimensional
%       K:  # of clusters
% OUTPUT:
%       Y: lables of clusters
%       C: ?
fprintf('EM for Gaussian mixture: running ... \n');

[d,n] = size(XX);
% yij is a row vector of indicator
% yi is lables
zij = zeros(1,n);
zi = zeros(1,n);
% k is assumed to be known
%{
----- test -----
miu = [1,2;3,4]; % test
sigma = [.9 .4; .4 .3]; % test
pi = [0.6,0.7]; % test
[miu,sigma,pi,nj,zij,zi]=iter_process_em(2,X,miu,sigma,pi,zij,zi); % test
%}
%[miu,pi,sigma] = init_theta(X,k);
miu = init_miu;
pi = init_pi;
sigma = init_sigma;

while true
    old_miu = miu;
    old_sigma = sigma;
    old_pi = pi;
    [miu,sigma,pi,nj,zij,zi] = iter_process_em(K,XX,old_miu,old_sigma,old_pi,...
                                               zij,zi);
    if norm(miu-old_miu)<1e-5;
        Y = zi;
        break
    end
end
    
end

%% One round process
function [miu,sigma,PiJ,Nj,zij,zi] = iter_process_em(K,XX,miu,sigma,pi,zij,zi)
[d,n] = size(XX);
% ==== Calculate the new zij ====
for ii=1:n
    Pi_norm = zeros(1,K);
    sum_normK = 0;
    for kk = 1:K
        Pi_norm(:,kk) = pi(:,kk) * mvnpdf(XX(:,ii),miu(:,kk),sigma(:,:,kk)); % if =0
                                                                    ...not in K clusters
                                                                        ... K++
        sum_normK = sum_normK + Pi_norm(:,kk);
    end
    max_pn = max(Pi_norm);
    max_k = find(Pi_norm == max_pn);
    if max_pn == 0
        zij(1,ii) = 0;
    else
        zi(1,ii) = max_k;
        zij(1,ii) = max_pn./sum_normK;
    end
end

% ==== Calculate the new theta ====
% Nj -- the number of point assigned to cluster j
Nj = zeros(1,K);
for kkk = 1:K
    j = find(zi == kkk); % find out that whose label is j
    for fj = j
        Nj(1,kkk) = Nj(1,kkk) + zij(1,fj); % new Nj for cluster j
    end
end

% PiJ -- the prob. of point assigned to cluster j
PiJ = zeros(1,K);
for kv = 1:K
    PiJ(1,kv) = Nj(1,kv) / n; % new pi
end

% miu -- the miu of cluster j
zij_x = zeros(d,K); % zij * xi
for kvv = 1:K
    jj = find(zi == kvv); % find out that whose label is j
    for fjj = jj
        zij_x(:,kvv) = zij_x(:,kvv) + zij(1,fjj) * XX(:,fjj);
    end
    miu(:,kvv) = zij_x(:,kvv) / Nj(1,kvv);
end

% sigma -- the sigma of cluster j
zij_x_miu = zeros(d,d,K); % zij * (xi-miuj) * (xi-miuj)'
for kvi = 1:K
    jjj = find(zi == kvi);
    for fjjj = jjj
        temp = zij(1,fjjj) * (XX(:,fjjj)-miu(:,kvi)) * (XX(:,fjjj)-miu(:,kvi))';
        zij_x_miu(:,:,kvi) = zij_x_miu(:,:,kvi) + temp;
    end
    sigma(:,:,kvi) = zij_x_miu(:,:,kvi) / Nj(1,kvi);
end

end

