%% tworzymy robota i rysujemy

clc
robot = genEmptyRobot();
a1 = 50;
a2 = 600;
a3 = 400;
a4 = 400;
a5 = 200;
a6 = 187;
a7 = 80;
a8 = 30;
% [Rz Tz Tx Rx], 0 jesli wartoœæ jest sta³a, 1 jeœli jest zmienna, max
% jedna 1

% robot = addMatrice(robot,  0, 0, 0, -pi/2,          [0,0,0,0]);

robot = addMatrice(robot,  -pi/2, a2, a1, 0,          [0,0,1,0]);
% robot = addMatrice(robot,  0, 0, a2, 0,          [0,0,0,0]);

robot = addMatrice(robot,  pi/2, a3, 0, 0,          [0,0,0,1]);

robot = addMatrice(robot,  -pi/2,  a4+a5,0, 0,                 [0,0,0,1]);
robot = addMatrice(robot,  0, 0, 0, 0,                 [1,0,0,0]);



% wartoœæ wyjœciowych wspó³¿ednych z³aczowych
robot.bindGP = [500 0 0.1  0];
% robot.bindGP = [400 0.3 -0.1  0]; %>     1552.5   -59.9    155.4    1

robot.initialPosition = [0 0 0 0];
robot.min = [0 -90 -180  -360]*pi/180;
robot.max = [0 90 22 360]*pi/180;
robot.max(1) = 1000; 
robot.max_v = [328 300 375 375 375 600]*pi/180;
robot.max_a = [1 1 1 1 1 1]*0.05;
robot.efector_radius = 5;

% kinematyka odwrotna g³upieje przy jointach pryzmatycznych, ta wartoœc to
% naprawia/ ustaliæ indywidualnie dla ka¿dego robota
robot.tweak = 800000;
% close(1)
 figure(1)
drawRobot(robot,  robot.bindGP, 'k', 3);
simulateRobotFi(robot, robot.bindGP)
%% definiujemy trasê
points = [1.5970    0.0599    0.5500    0.0010;
    1.5036    0.0658    0.0016    0.0010;
    1.4750   -0.2412    0.2010    0.0010
    ]*1000;
%% def punktów trasy


