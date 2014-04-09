syms x1 x2 x3 x4 real;
%% 2.1 niestabilny
r1 = 4*x2;
r2 = 2*x3;
r3 = x1^2-6*x1-4*x2-x3;
% x1 = [0 6]
%% 2.2 niestabilny??
r1 = 4*x2;
r2 = 2*x3;
r3 = x1*(x1^2-6)-4*x2-x3;
% x1 = [0 6^1/2 -6^1/2]
%% 2.3
%%
out = solve(r1,r2,r3, 'x1, x2, x3')
%%

f1x1 = diff(r1, x1);
f2x1 = diff(r2, x1);
f3x1 = diff(r3, x1);

f1x2 = diff(r1, x2);
f2x2 = diff(r2, x2);
f3x2 = diff(r3, x2);


f1x3 = diff(r1, x3);
f2x3 = diff(r2, x3);
f3x3 = diff(r3, x3);


A = [f1x1 f2x1 f3x1; f1x2 f2x2 f3x2; f1x3 f2x3 f3x3]'
% w wierszach sta³e funkcje 
%% podstawienie punktu pracy

Al = subs(A, x1, out.x1(1))

%% wartoœci w³asne

Al = single(subs(A, x1, out.x1(3)));
w = eig(Al)