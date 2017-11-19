function plotCluster(X,yi)

[~,n] = size(X);
color = 'krgbmcy';
max_k = max(yi);
min_k = min(yi);

figure(gcf);
clf;
for i = 1:n
    xi = X(:,i);
    xi_1d = xi(1);
    xi_2d = xi(2);
    scatter(xi_1d,xi_2d,16,color(mod(yi(i),max_k)+1),'filled')
    hold on;
end
%legend('')
axis([-14 14 -14 14])
grid on
hold off
end

