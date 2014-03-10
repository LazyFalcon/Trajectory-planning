syms q1 real;
syms d1 d2 real;
syms q2 real;
syms q3 real;
syms q4 real;
syms z1 z2 z3 z4 real

% matr = simulateRobotFi(robot, [q1 q2 q3 q4])
% matr = simulateRobotFiMatrices(robot, [q1 q2 q3 q4]);
% matr{1};
% matr{2};
% matr{3};
% matr{4};
% 
% mA(z1,z2,z3,z4)

A1 = mA(0, d1+a1, a2, -pi/2);
A2 = mA(q2, 0, a3, pi/2);
A3 = mA(pi/2+q3, 0, a4+a5, 0);
A4 = mA(0, 0, 0, q4)

A1*A2*A3

A = A1*A2*A3*A4*[0 0 0 1]'
 p = A1*[0 0 0 1]';

