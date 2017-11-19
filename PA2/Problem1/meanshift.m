function [labels,clusters,pt_in_h] = meanshift(X,h)
% Perform Meanshift algorithm for fitting the Gaussian mixture model.
% INPUT: 
%       X: [d x n] data matrix
%       h: h
% OUTPUT:
%       labels: label set of cluster [1*n]

%% some basic para. 
[d,n] = size(X);
I = eye(d);
numClust = 0; % number of cluster
clusters = []; 
threshold = 1e-3*h;
labels = zeros(1,n);
sign = zeros(1,n); % sign the points which is located in the cluster
%% Mean shift start
for i = 1:n
    if sign(i) == 1
        continue; % the signed point is already in the cluster do not need...
                    % to be calculated
    end
    t = 0;
    %labels = zeros(d,n); % i.e. local peak
    init_miu = X(:,i);
    sigma = (h^2) * I; % [d*d]
    pt_in_h = []; % the point located in the kernel with h
    sum_xn = zeros(d,1);
    sum_n = zeros(d,1);
    while true
        fprintf('Running...Round %d\n',t)
        if t == 0 
            old_miu = init_miu;
        else
            old_miu = new_miu;
        end
        % find the points within h
        distance = sum((repmat(old_miu,1,n) - X).^2);
        pt_in_h = find(distance < (h^2)); 
        for ii = pt_in_h
            sum_xn = sum_xn + X(:,ii) * mvnpdf(X(:,ii),old_miu,sigma);
            sum_n = sum_n + mvnpdf(X(:,ii),old_miu,sigma);
        end
        new_miu = sum_xn./sum_n;
        
        %% convergence?
        if norm(new_miu - old_miu) < threshold
            
            % can the new cluster and old cluster be merged?
            merge = 0; 
            for k = 1:numClust
                dist2other = norm(new_miu-clusters(:,k));%distance from posible new clust max to old clust max
                if dist2other < h/2  %if its within h/2 merge new and old
                    merge = k;
                    break
                end  
            end
            
            % merge? -> the max mean of new and old becomes the mean after
            %           merge
            % not merge? -> create a new cluster and record the new mean
            
            if merge > 0    % merge is equal to the number of cluster
                clusters(:,merge) = 0.5*(new_miu+clusters(:,merge)); 
                labels(i) = merge;    %add these votes to the merged cluster
                for s = pt_in_h
                    if sign(s) == 0
                        sign(s) = 1;
                        labels(s) = merge;
                    end
                end
            else    % create a new cluster
                numClust = numClust+1; %increment clusters
                clusters(:,numClust) = new_miu;     %record the mean  
                labels(i) = numClust;
                for s = pt_in_h
                    sign(s) = 1;
                    labels(s) = numClust;
                end
            end
            break;
        end
        t = t + 1; % iteration + 1
    end
        
end

