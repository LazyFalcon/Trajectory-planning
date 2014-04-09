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
Pa = p - pw


A1*A2*A3;
% T03 = A1*A2*A3*A4*[0 0 d4 1]';
T03 = A1*A2*A3*[0 0 d4 1]';
%  p = A1*A2*A3*[0 0 0 1]';
%%
clc

A1p = mA(0, 500, 600, -pi/2);
A2p = mA(  0.8,0, 400, pi/2);
A3p = mA( -0.4,0,600, -pi/2);
A4p = mA( 0.5,0,0, 0);

T0epp =  single(A1p*A2p*A3p*A4p); % zadanie
T03pp =  single(A1p*A2p*A3p); % zadanie
 r03t = T03pp(1:3,1:3)'
 r0e = T0epp(1:3,1:3)'

que = single(r03t/r0e)

ioefwj3 = atan2(que(2,1), que(1,1))
%%
clc
T03 = A1*A2*A3;
pa = T03*[0 0 d4 1]';
%%7
T03p = subs(T03, d1, 0.2);
T03p = subs(T03p, a1, 0.2);
T03p = subs(T03p, a2, 0.6);
T03p = subs(T03p, a3, 0.2);
T03p = subs(T03p, d4, 0.7);


%%
points =  [  
    1467.9    0100.9    54.8    1.0;
    1310.7    0255.3    145.2    1.0;
    1289.3    0197.4    380.8    1.0;
    1367.9   -0065.8    589.0    1.0;
    1339.3   -0267.5    119.4    1.0;
    1167.9   -0346.5   700.5    1.0;
    1253.6    0390.4    800.1    1.0;
    1389.3    0144.7    400.1    1.0;
];
  
%%
% gps = XXX_MR_numericSolve(Pa', T03p,'q1, q2, q3')
    d4p = 0.7;
    pa = T03p * [0 0 d4p 1]';
   
    % pa to jest p4, Pa jest symboliczny, równanie przyrównuje do zera
    % p jest punktem docelowym
    y1 = Pa(1) - pa(1);
    y2 = Pa(2) - pa(2);
    y3 = Pa(3) - pa(3);
    %% pierwsze trzy wspó³¿edne
    out = solve(y1, y2, y3, 'q1, q2, q3');

    %% pozosta³e wspó³zedne
% mo¿emy teraz wyznaczyæ macierz T03, z tym ¿e wspó³zedne wyznaczaliœmy dla punktu T04*[0001] równowa¿nemu 
% punktowi: T03*[00 d4 1]

R03 =  subs(T03p, q1, out.q1(1));
R03 =  subs(R03, q2, out.q2(1));
R03 =  subs(R03, q3, out.q3(1));
r03 = single(R03(1:3, 1:3));

% macierz prowadz¹ca z 03 do 3e, transpozycja macierzy rotacji jest jej
% odwrotnoœci¹
% to nie jest to..., szkoda
r3e = r03'*r0e
T3e = zeros(4,4);
T3e(1:3, 1:3) = r3e;
T3e(1:4, 4) = pw';
T3e(4,4) = 1;

T0es = R03*A4*A5*A6;
%% 
T0es = subs(T0es, d4, 0.7);
T0es = subs(T0es, d6, d6p);

p3 = R03*[0 0 0 1]';
P = T0es*[0 0 0 1]';
% z1 =  P(1) - p(1) - p3(1);
% z2 =  P(2) - p(2) - p3(2);
% z3 =  P(3) - p(3) - p3(3);
z1 =  P(1) - p(1);
z2 =  P(2) - p(2);
z3 =  P(3) - p(3);

out2 = solve(z1,z2,z3, 'q4, q5, q6')



