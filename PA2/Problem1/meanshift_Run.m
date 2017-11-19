close all; clear;
dataset = load('cluster_data.mat');
X1 = dataset.dataA_X;
X2 = dataset.dataB_X;
X3 = dataset.dataC_X;


%% RUN -- DATA A
% Because I use each data point xi as aninitial point 
% Thus the time of running will be longer than EM's
[labels_a,clusters_a,pt_in_h_a] = meanshift(X1,5); % h=5 is the best
plotCluster(X1,labels_a);

%% RUN -- DATA B
% Because I use each data point xi as aninitial point 
% Thus the time of running will be longer than EM's
[labels_b,clusters_b,pt_in_h_b] = meanshift(X2,4.5743);
figure;
plotCluster(X2,labels_b);

%% RUN -- DATA C
% Because I use each data point xi as aninitial point 
% Thus the time of running will be longer than EM's
[labels_c,clusters_c,pt_in_h_c] = meanshift(X3,5); % h=5 is the best
figure;
plotCluster(X3,labels_c);
