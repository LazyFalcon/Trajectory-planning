syms d1 q2 q3 q4 real;
syms a1 a2 a3 real;
syms d1 a1 a2 a3 d4 d6 real;
syms q1 q2 q3 q4 q5 q6 real;

% matr = simulateRobotFi(robot, [q1 q2 q3 q4])
% matr = simulateRobotFiMatrices(robot, [q1 q2 q3 q4]);
% matr{1};
% matr{2};
% matr{3};
% matr{4};
%
% mA(z1,z2,z3,z4)
% Rz Tz Tx Rx
clc

A1 = mA (q1, d1, a1, sym(pi/2));
A2 = mA (q2+sym(pi/2), 0, a2, 0);
A3 = mA (q3, 0, a3, sym(pi/2));
A4 = mA (q4, d4, 0, sym(-pi/2));
A5 = mA (q5, 0, 0, sym(pi/2));
A6 = mA (q6, d6, 0, 0);

Px=1;
Py=-0.4;
Pz=0.5;
phi=0.5;
theta=double(pi/3);
psi=double(pi/6);
T0e = trax(Px)*tray(Py)*traz(Pz)*rotz(phi)*roty(theta)*rotx(psi)
r0e = T0e(1:3, 1:3);

d6p = 0.2;
p = T0e*[0 0 0 1]';
pw = T0e(1:4, 3)*d6p;
Pa = p - pw;
%% obliczamy q1
th1 = atan2(pa.x, pa.y);
%% przesuwamy pa
    p2 = A1*[0 0 0 1]';
    p2 = subs(p2, {q1, d1, a1}, {th1, 0.2, 0.2});
    pa2 = pa - p2;
 %% obliczamy wymiary trójk¹ta utworzonego przez cz³ony 2 i 3
 
 a = 0.6;
 b = A3*A4*[0 0 0 1]';
 b = w_len(subs(b, {q3 q4 a3 d4}, {0 0 0.2 0.7}));
 c = w_len(pa2);
 
 % z tw. cosinusów:
 alfa = acos( (-b^2 +a^2 + c^2)/  2/a/c);
 beta = acos( (-c^2 +a^2 + b^2)/  2/a/b);
 gamma = acos( (-a^2 +b^2 + c^2)/  2/b/c);
 theta = atan2(  sqrt(pa2(1)^2 + pa2(2)^2), pa2(3) );
 th2 = theta + alfa;
 th3 = beta + acos( (-0.7^ + 0.2^2+b^2)/2/0.2/b);













