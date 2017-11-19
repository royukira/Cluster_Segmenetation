function [idx,clusters] = KMeans(dataX,dataY,k)
%{
Function Description:
    Implement K-Means Algorithm.
Parameters Description:
    dataX: dataset points X. Each column is a data point,xi belongs
    2 dimations.
    
    dataY: dataset true labels.

    k:number of clusters.
Returns:
    idx: mark of Xs.
    clusters: location of clusters.
%}
    [n,m]=size(dataX);
    idx = zeros(m,1);
    clusters = zeros(k,n);
    
    %store last center
    u = zeros(k,n);
    %store updated center
    v = zeros(k,n);
    
    %initial
    %t=1;
    
    %for i=1:k
     %   u(i,:) = dataX(:,t);
      %  t=t+m/k;
    %end
    
    u(1,:)=[5,-5];
    u(2,:)=[-5,-5];
    u(3,:)=[-5,5];
    u(4,:)=[5,5];
    
    %start implementaion
    while true
        for i =1:m
            %dis stroes distance from each point to center k.
            dis = zeros(k,1);
            for j=1:k
                sum_dis = 0;
                for t=1:n
                    sum_dis=sum_dis+(u(j,t)-dataX(t,i))^2;
                end
                dis(j) = sqrt(sum_dis);
            end
            %find the cloest distance to center k,put it in
            [~,index] = sort(dis);
            idx(i,1:2) = dataX(:,i);
            idx(i,3) = index(1);
        end
        for i=1:k
            total_dis = zeros(1,n);
            num_i=0;
            for j=1:m
                if idx(j,3)==i
                    for t=1:n
                        total_dis(1,t) = total_dis(1,t)+dataX(t,j);
                    end
                    num_i=num_i+1;
                end
            end
            v(i,:) = total_dis(1,:)/num_i;
        end
        %algorithm finish
        if norm(v-u)<0.01
            clusters = v;
            break;
        end
        u=v;
    end
    for i=1:m
        if idx(i,3) == 1
            plot(idx(i,1),idx(i,2),'r.');
        elseif idx(i,3) == 2
            plot(idx(i,1),idx(i,2),'b.');
        elseif idx(i,3) == 3
            plot(idx(i,1),idx(i,2),'c.');
        else
            plot(idx(i,1),idx(i,2),'g.');
        end
        hold on;
    end
    
    plot(clusters(:,1),clusters(:,2),'kx','LineWidth',2);
end