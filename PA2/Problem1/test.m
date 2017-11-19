
%% Just for testing
dataset = load('cluster_data.mat');
k = 4; % k is assumed to be known
X1 = dataset.dataA_X;
%partA_GMM(X1,Y1,k)
%[pMiu,pPi,pSigma] = init(X1,k,1);
[labels,clusters,pt_in_h] = meanshift(X1,5);
plotCluster(X1,labels);