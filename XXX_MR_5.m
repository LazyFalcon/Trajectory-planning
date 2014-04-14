clc
% clear all

syms Ek1 Ek2 Ek3 J2 m1 m2 m3  real;
syms d1 q2 d3 p2 real;
syms Ep1 Ep2 Ep3 g real;
syms dd1 dq2 dd3 real;
syms ddd1 ddq2 ddd3 real;
%% kinetyczne
Ek1 = 1/2 * m1*dd1^2;
Ek2 = 1/2*( m2*dd1^2 + dq2^2*J2);
Ek3 = 1/2*m3*( dd1^2 + d3^2*dq2^2 + dd3^2 );

Ek = simplify(Ek1+Ek2+Ek3);

%% potencjalne
Ep1 = -m1*d1*g;
Ep2 = -m2*(d1-p2*sin(q2))*g;
Ep3 = -m3*(d1-d3*sin(q2))*g;

Ep = simplify(Ep1+Ep2+Ep3);

%% potencja³
L = Ek-Ep;

%% r Lagrangea
f11 = diff(L, 'dd1');
f21 = diff(L, 'dq2');
f31 = diff(L, 'dd3');

%%
S1 = {'d1','q2','d3','dd1','dq2','dd3'};
S2 = {'d1(t)','q2(t)','d3(t)','dd1(t)','dq2(t)','dd3(t)'};
f12 = subs(f11, S1, S2);
f22 = subs(f21, S1, S2);
f32 = subs(f31, S1, S2);


%% pochodne wzglêdem czasu
f13 = diff(f12, 't');
f23 = diff(f22, 't');
f33 = diff(f32, 't');

%% ujednolicenie

S3 = {'diff(d1(t),t)','diff(q2(t),t)','diff(d3(t),t)','diff(dd1(t),t)','diff(dq2(t),t)','diff(dd3(t),t)'};
S4 = {'dd1','dq2','dd3','ddd1','ddq2','ddd3',};
f14 = subs(f13, S3, S4);
f24 = subs(f23, S3, S4);
f34 = subs(f33, S3, S4);

S5 = {'dd1(t)','dq2(t)','dd3(t)'};
S6 = {'dd1','dq2','dd3'};
f15 = subs(f14, S5, S6);
f25 = subs(f24, S5, S6);
f35 = subs(f34, S5, S6);

S7 = {'d1(t)','q2(t)','d3(t)'};
S8 = {'d1','q2','d3'};
r11 = subs(f15, S7, S8);
r21 = subs(f25, S7, S8);
r31 = subs(f35, S7, S8);

r12 = diff(L, 'd1');
r22 = diff(L, 'q2');
r32 = diff(L, 'd3');

%% zestawienie
r1 = simplify(r11 - r12)
r2 = simplify(r21 - r22)
r3 = simplify(r31 - r32)

%% 