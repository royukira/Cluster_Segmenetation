function [prob,result] = partA_GMM(dataX,dataY,k)
%{
Function Description:
    Implement GMM using EM Algorithm.
Parameters Description:
    dataX: dataset points X. Each column is a data point,xi belongs
    2 dimations.
    
    dataY: dataset true labels.

    k:number of clusters.
Returns:
    idx: mark of Xs.
    clusters: location of clusters.
%}
    %rand initial centers
    threshold = 1e-5;
    [D,N] = size(dataX);
    random = randperm(N)
    X= dataX';
    centers = X(random(1:k),:);
    
    
    %initial values
    [MiuHat,PiHat,SigmaHat] = init();
    LError = -inf; %last error
    Iterator = 0;
    
    %EM Altorithm start
    while true
        %E step
        prob = cal_prob();
        %determine which xi is from which GMM
        theta = prob.*repmat(PiHat,N,1);
        theta = theta./repmat(sum(theta,2),1,k);
        
        %M step
        Nks = sum(theta,1); %prob of k th GMM
        
        %update values
        MiuHat = diag(1./Nks)*theta'*X;
        PiHat = Nks/N;
        
        %update distance
        distance = repmat(sum(X.*X,2),1,k)+...
            repmat(sum(MiuHat.*MiuHat,2)',N,1)-...
            2*X*MiuHat';
        [~,labels] = min(distance,[],2);
        %update k sigma
        for jj=1:k
            Xshift = X-repmat(MiuHat(jj,:),N,1);
            SigmaHat(:,:,jj) = (Xshift'*...
                (diag(theta(:,jj))*Xshift))/Nks(jj);
        end
        
        %check cov
        L = sum(log(prob*PiHat'));
        if L-LError<threshold
            break;
        end
        LError = L;
        Iterator = Iterator+1;
    end
    result = [];
    result.Miu = MiuHat;
    result.Sigma = SigmaHat;
    result.Pi = PiHat;
    result.labels = labels;
    errorNum = 0;
    %plot diagram
    for i=1:N
        if result.labels(i) == 1
            plot(X(i,1),X(i,2),'r.');
        elseif result.labels(i) == 2
            plot(X(i,1),X(i,2),'b.');
        elseif result.labels(i) == 3
            plot(X(i,1),X(i,2),'c.');
        else
            plot(X(i,1),X(i,2),'g.');
        end
        hold on;
        if result.labels(i)~=dataY(i)
            errorNum = errorNum+1;
        end
    end
    plot(result.Miu(:,1),result.Miu(:,2),'kx','LineWidth',2);
    title(['Implement clustering by using EM-GMM (Iteration =',num2str(Iterator),')']);
    xlabel('x_1');
    ylabel('x_2');
    %Function Definition
    function [pMiu,pPi,pSigma] = init()
        pMiu = centers; %center k
        pPi = zeros(1,k); %influenct factor
        pSigma = zeros(D,D,k); %cov matirx each one is DxD
        %calcute distance
        a = repmat(sum(X.*X,2),1,k);
        b = repmat(sum(pMiu.*pMiu,2)',N,1);
        c = 2*X*pMiu';
        distance = a+...
            b-...
            c;
        [~,labels] = min(distance,[],2);
        for j=1:k
            Xj = X(labels == j,:);
            pPi(j) = size(Xj,1)/N;
            pSigma(:,:,j) = cov(Xj);
        end
    end
    
    %calculate probability
    function prob = cal_prob()
        prob = zeros(N,k);
        for j=1:k
            Xshift = X - repmat(MiuHat(j,:),N,1);
            inv_sigma = inv(SigmaHat(:,:,j));
            tempvalue = sum((Xshift*inv_sigma).*Xshift,2);
            coef = 2*pi^(-D/2)*sqrt(det(inv_sigma));
            prob(:,j) = coef*exp(-0.5*tempvalue);
        end
    end
end