 % test kolizji scierzki z przeszkodami
%  clear all
clc
rob = genEmptyRobot();
a1 = 203;
a2z = 132;
a2x = 75;
a3 = 270;
a4 = 90;
a5 = 108;
a6 = 187;
a7 = 80;
a8 = 30;
% [Rx Tx Tz Rz], 0 jesli wartoœæ jest sta³a, 1 jeœli jest zmienna, max
% jedna 1

rob = addMatrice(rob,  -pi/2,a2x, a2z, 0, [0,0,0,1]);
rob = addMatrice(rob,  0,a3, 0, -pi/2, [0,0,0,1]);
rob = addMatrice(rob,  0,sqrt(a4^2 + a5^2), 0, 0.6947, [0,0,0,1]);
% rob = addMatrice(rob,  0,a5, 0, pi/2, [0,0,0,0]);
rob = addMatrice(rob,  0,a6, 0, 0.8760, [1,0,0,0]);
rob = addMatrice(rob,  0,a7, 0, 0, [0,0,0,1]);
rob = addMatrice(rob,  -pi/2,a8, 0, 0, [1,0,0,0]);

% wartoœæ wyjœciowych wspó³¿ednych z³aczowych
rob.bindGP = [0 0 0 0 0 90]*pi/180;

rob.initialPosition = [0 0 203 0];
rob.min = [-170 -100 -29  -190 -120 -360 ]*pi/180;
rob.max = [170 135 256 190 120 360]*pi/180;
rob.max_v = [328 300 375 375 375 600]*pi/180;
rob.max_a = [1 1 1 1 1 1]*0.05;
rob.efector_radius = 5;
drawRobot(rob, rob.bindGP,'k',3, 'first');
view([0 0])
axis([-10 600 -200 200 200 800])