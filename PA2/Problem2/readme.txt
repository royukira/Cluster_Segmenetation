
====== Segmentation ======
@ Written by Roy Cheung 


+++ Algorithm Implementation +++

>> kmean_segImage.m -- implement K-means Algorithm
>> Kmean_sed.m -- implement K-means Algorithm (scaling each dimension in the  feature vector x by an appropriate amount)
>> em_segImage.m -- implement EM for GMM Algorithm
>> ms_segImage.m -- implement Mean-shift Alogrithm
>> ms_sed.m -- implement Mean-shift Alogrithm (scaling each dimension in the  feature vector x by an appropriate amount)


+++ Initialization Function +++

>> init.m -- Initialization function for EM 
			 Choose a initial miu firstly, then using minial distance of ||x-init_miu||^2 to assign a coarse label on each point and calculate the initial covariance of each cluster

>> init_para.m -- random initialization strategy


+++ Run the Algorithms +++

>> kmean_run.m -- Run the K-means algorithm function
>> em_run.m -- Run the EM for GMM algorithm function
>> ms_run.m -- Run the Mean-shift algorithm function


+++ Get features of pictures +++

>> getfeatures.m -- MATLAB function for extracting features from an image.


+++ Plot Function +++

>> labels2segm.m -- MATLAB function for generating a segmentation image from the cluster labels.
>> colorsegm.m -- MATLAB function to create a nicely colored segmentation image.