syms x1 x2 x3 x4 real;
%% 2.3
r1 = x2;
r2 = -x1 - 2*x2 - 6*x2^3;
%% 2.4 0 i ujemne wartoœci, ergo stabilny?
r1 = x2-2*x1*(x1^2 + x2^2);
r2 = -6*x1 - 4*x2*(x1^2 + x2^2);

%%
out = solve(r1,r2, 'x1, x2')
%%
% http://bcpw.bg.pw.edu.pl/Content/767/11zdau_stabilnosc.pdf
V =0.5*( x1^2 + x2^2);

V = x1^2 + x2^2;
% dV = diff(V,x1) + diff(V,x2)
% dV = -2*x2^2 - 6*x2^4;
dv = simplify(r1*diff(V, x1) + r2*diff(V,x2))
%% dla 2.4 5 rozwi¹zañ
% i=1;
% dVl = single(subs(dV, {x1, x2}, {out.x1(i), out.x2(i)}))
dVl = single(subs(dv, {x1, x2}, {-0.1,0.1}))


%%
X1 = -2:0.1:2;
X2 = -2:0.1:2;
X = zeros(length(X1),length(X2));
Y = zeros(length(X1),length(X2));
Z = zeros(length(X1),length(X2));
u=1;
% zrób powierzchniê
for k = 1:1:length(X1)
for j = 1:1:length(X2)
    Z(k,j) = single(subs(V, {x1, x2}, {X1(k), X2(j)}));
    X(k,j) = X1(k);
    Y(k,j) = X2(j);
    u=u+1;
end
end
%% 
h = surf(X,Y,Z);
shading interp
% set(h,'edgecolor','k')