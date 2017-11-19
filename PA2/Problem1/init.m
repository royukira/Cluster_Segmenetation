
%% Initialization function for EM 
function [init_miu,init_Pi,init_Sigma] = init(X,k,m)
% INPUT:
%       X: d x n data matrix
%       k: k dimension
%       m: initial miu for each data set (1--A, 2--B, 3--C)
% OUTPUT:
%       init_miu : initial miu
%       init_Pi: initial Pi
%       initial_Sigma: initial Sigma

[d,n] = size(X);
%init_miu = init_para(X,k); % Randomly choose miu
% 1 -- dataA
if m == 1
    init_miu = zeros(d,k);
    init_miu(:,1)=[10,-10];
    init_miu(:,2)=[-10,-10];
    init_miu(:,3)=[-10,10];
    init_miu(:,4)=[10,10];
end
% 2 -- dataB
if m == 2
    init_miu = zeros(d,k);
    init_miu(:,1)=[-5,0];
    init_miu(:,2)=[-1,0];
    init_miu(:,3)=[1,0];
    init_miu(:,4)=[5,0];
end
% 3 -- dataC
if m == 3
    init_miu = zeros(d,k);
    init_miu(:,1)=[-10,0];
    init_miu(:,2)=[-1,0];
    init_miu(:,3)=[1,0];
    init_miu(:,4)=[10,0];
end

init_Pi = zeros(1,k); %influenct factor
init_Sigma = zeros(d,d,k); %cov matirx each one is DxD

%calcute distance of ||x-init_miu||^2
a=repmat(sum(X'.*X',2),1,k);
b=repmat(sum(init_miu'.*init_miu',2)',n,1);
c=2*X'*init_miu;
distance = a+b-c;

[~,labels] = min(distance,[],2);

for j=1:k
    Xj = X(:,labels == j);
    init_Pi(j) = size(Xj,1)/n;
    cc = cov(Xj');
    init_Sigma(:,:,j) = cc;
end

end
