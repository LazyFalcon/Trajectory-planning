syms d1 q2 q3 q4 ;
syms a1 a2 a3 ;

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

A1 = mA(0, d1, a1, sym(-pi/2));
A2 = mA(q2, 0, a2, sym(pi/2));
A3 = mA(q3, 0, a3, sym(-pi/2));
A4 = mA(q4, 0, 0, 0);

A1*A2*A3;
A = A1*A2*A3*A4*[0 0 0 1]';
 p = A1*A2*A3*[0 0 0 1]';
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
pa = T03*[0 0 0 1]';
%%7
T03p = subs(T03, a1, 600);
T03p = subs(T03p, a2, 400);
T03p = subs(T03p, a3, 600);



A1p = subs(A1, a1, 600);
A2p = subs(A2, a2, 400);
A3p = subs(A3, a3, 600);    

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
gps =[

  934.0858    0.5046    0.1690         0;
   25.4451   -0.7171    0.4395    0.5000;
  203.1848   -0.7769    0.3353         0;
  554.0898   -0.6909   -0.1099   -0.5000;
  695.1744    0.6617   -0.4621         0;
  677.5646    0.8786   -0.6157    0.5000;
  617.2732    0.7015    0.7085         0;
  649.8094    0.6376    0.2436         0;
  ];
   
%% 
gps = XXX_MR_pathIK(points, T03p*A4,'d1, q2, q3');
% sprawdzenie wyników, symulacj¹
XXX_MR_simulateRobotFi({A1p, A2p, A3p}, gps{1});
XXX_MR_simulateRobotFi({A1p, A2p, A3p}, gps{2});
%%
Q4 = [0 0.5 0 -0.5 0 0.5 0 0.5];
gps{1}(:,4) = Q4;
gps{2}(:,4) = Q4;


%%

subs(A1p, gps{1}(1,1))*subs(A2p, gps{1}(1,2))*subs(A3p, gps{1}(1,3))*[0 0 0 1]'