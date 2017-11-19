close all; clear;
dataset = load('cluster_data.mat');
k = 4; % k is assumed to be known
X1 = dataset.dataA_X;
X2 = dataset.dataB_X;
X3 = dataset.dataC_X;

%% RUN -- Data A
% == init_theta --> use k-means ressult as initialization
% == init --> use distance
% =================================
%[init_miu1,init_pi1,init_sigma1] = init_theta(X1,k,1); 
[init_miu1,init_pi1,init_sigma1] = init(X1,k,1);
[miu_a,sigma_a,pi_a,nj_a,zij_a,label_a] = emGmm(X1,k,init_miu1,init_sigma1,init_pi1);
plotCluster(X1,label_a);

%% RUN -- Data B
% == init_theta --> use k-means ressult as initialization
% == init --> use distance
% =================================
%[init_miu2,init_pi2,init_sigma2] = init_theta(X2,k,2);
[init_miu2,init_pi2,init_sigma2] = init(X2,k,2);
[miu_b,sigma_b,pi_b,nj_b,zij_b,label_b] = emGmm(X2,k,init_miu2,init_sigma2,init_pi2);
figure;
plotCluster(X2,label_b);

%% RUN -- Data C
% == init_theta --> use k-means ressult as initialization
% == init --> use distance
% =================================
%[init_miu3,init_pi3,init_sigma3] = init_theta(X3,k,3);
[init_miu3,init_pi3,init_sigma3] = init(X3,k,3);
[miu_c,sigma_c,pi_c,nj_c,zij_c,label_c] = emGmm(X3,k,init_miu3,init_sigma3,init_pi3);
figure;
plotCluster(X3,label_c);