
====== Clustering data points ======
@ Written by Roy Cheung 


+++ Algorithm Implementation +++

>> k_means.m -- implement K-means Algorithm
>> emGmm.m -- implement EM for GMM Algorithm
>> meanshift.m -- implement Mean-shift Alogrithm


+++ Initialization Function +++

>> init.m -- Initialization function for EM 
			 Choose a initial miu firstly, then using minial distance of ||x-init_miu||^2 to assign a coarse label on each point and calculate the initial covariance of each cluster

>> init_para.m -- random initialization strategy
>> init_theta.m -- Using the outcomes of K-means as initial parameters


+++ Run the Algorithms +++

>> kmeans_run.m -- Run the K-means algorithm function
>> emGmm_run.m -- Run the EM for GMM algorithm function
>> meanshift_Run.m -- Run the Mean-shift algorithm function


+++ Plot Function +++

>> plotCluster.m -- For ploting


