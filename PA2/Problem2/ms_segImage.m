function [labels,clusters] = ms_segImage(XX,hc,hp,h)
% Perform Meanshift algorithm for fitting the Gaussian mixture model.
% INPUT: 
%       XX: [d x n] data matrix
%       h: bandwidth
% OUTPUT:
%       labels: label set of cluster [1*n]

%% some basic para. 
[d,n] = size(XX);
%I = eye(d/2); % [u,v] [cx,cy]
numClust = 0; % number of cluster
clusters = []; 
%h = norm([hc,hp]);
threshold = 1e-3*h;
labels = zeros(1,n);
sign = zeros(1,n); % sign the points which is located in the h
%% Mean shift start
for i = 1:n
    if sign(i) == 1
        continue;
    end
    t = 0;
    %labels = zeros(d,n); % i.e. local peak
    init_miu = XX(:,i);
    %sigma = (h^2) * I; % [d*d]
    %sigma_c = (hc^2) * I;
    %sigma_p = (hp^2) * I;
    pt_in_h = []; % the point located in the kernel with h
    %pt_in_hc = [];
    %pt_in_hp = [];
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
        distance = sum((repmat(old_miu,1,n) - XX).^2);
        pt_in_h = find(distance < (h^2));  
        %dis_c = sum((repmat(old_miu(1:2),1,n) - XX(1:2,:)).^2);
        %dis_p = sum((repmat(old_miu(3:4),1,n) - XX(3:4,:)).^2);
        %pt_in_hc = find(dis_c < (hc^2));
        %pt_in_hp = find(dis_p < (hp^2));
        %pt_in_h = [pt_in_hc pt_in_hp];
        for ii = unique(pt_in_h)
            dis_c = (XX(1:2,ii)-old_miu(1:2))'*(XX(1:2,ii)-old_miu(1:2));
            dis_p = (XX(3:4,ii)-old_miu(3:4))'*(XX(3:4,ii)-old_miu(3:4));
            kernel = (1/4*(pi^2)*(hp^2)*(hc^2))*...
                        exp(-0.5*(1/hc^2)*dis_c...
                        -0.5*(1/hp^2)*dis_p);
                
            sum_xn = sum_xn + XX(:,ii) * kernel;
            sum_n = sum_n + kernel;
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
                        sign(s) = 1; % sign the point which do not need to be calculated anymore
                        labels(s) = merge; % label the point
                    end
                end
            else    % create a new cluster
                numClust = numClust+1; %increment clusters
                clusters(:,numClust) = new_miu;     %record the mean  
                labels(i) = numClust;
                for s = pt_in_h
                    sign(s) = 1; % sign the point which do not need to be calculated anymore
                    labels(s) = numClust; % label the point
                end
            end
            break;
        end
        t = t + 1; % iteration + 1
    end
        
end
end

