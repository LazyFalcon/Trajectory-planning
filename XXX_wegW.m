x1 = 0;
 
out = [];
for x1 = -0.5:0.05:0.5
for x2 =-0.5:0.05:0.5
    out = [out, - 4*x1^4 - 12*x1^2*x2^2 - 10*x1*x2 - 8*x2^4];
end
end
plot(out);

%%

out = solve('- 4*x1^4 - 12*x1^2*x2^2 - 10*x1*x2 - 8*x2^4 < 0', 'x1,x2')
%%

X1 = -1:0.005:1;
X2 = -0.7:0.005:0.7;
X = zeros(length(X1),length(X2));
Y = zeros(length(X1),length(X2));
Z = zeros(length(X1),length(X2));
u=1;
xy = [];
% zrób powierzchniê
for k = 1:1:length(X1)
for j = 1:1:length(X2)
    x1 = X1(k);
    x2 = X2(j);
    Z(k,j) = - 4*x1^4 - 12*x1^2*x2^2 - 10*x1*x2 - 8*x2^4;
    X(k,j) = X1(k);
    Y(k,j) = X2(j);
    if Z(k,j)>0
%         fprintf('%f %f\n', x1,x2)
        xy = [xy; x1,x2];
    end
    u=u+1;
end
end

plot(xy(:,1), xy(:,2),'.')
%% 
h = surf(X,Y,Z);
shading interp
% set(h,'edgecolor','k')
axis([-1 1 -1 1 0 1.2])
%%
plot(xy(:,1), xy(:,2),'.')

