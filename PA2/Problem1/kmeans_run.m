close all; clear;
K = 4;
dataset = load('cluster_data.mat');
X1 = dataset.dataA_X;
X2 = dataset.dataB_X;
X3 = dataset.dataC_X;

% [labels,indicator,miu] = k_means(X,K,m) 
%% Data A -- K-Means
[yi1,yij1,miu1] = k_means(X1,K,1);
plotCluster(X1,yi1);
%% Data B -- K-Means
[yi2,yij2,miu2] = k_means(X2,K,2);
figure;
plotCluster(X2,yi2);
%% Data C -- K-Means
[yi3,yij3,miu3] = k_means(X3,K,3);
figure;
plotCluster(X3,yi3);
