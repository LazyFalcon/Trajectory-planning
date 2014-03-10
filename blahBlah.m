
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

robot = addMatrice(robot,  0, a1, 0, 0,          [0,1,0,0]);
robot = addMatrice(robot,  0, 0, a2, -pi/2,          [0,0,0,0]);

robot = addMatrice(robot,  0, 0, a3, pi/2,          [1,0,0,0]);

robot = addMatrice(robot,  pi/2, 0, a4, 0,                 [1,0,0,0]);
robot = addMatrice(robot,  0, 0, a5, 0,                 [0,0,0,1]);



% wartoœæ wyjœciowych wspó³¿ednych z³aczowych
robot.bindGP = [100 0.4 -0.5  0];

robot.initialPosition = [0 0 0 0];
robot.min = [0 -90 -180  -360]*pi/180;
robot.max = [1000*180/pi 90 22 360]*pi/180;
robot.max_v = [328 300 375 375 375 600]*pi/180;
robot.max_a = [1 1 1 1 1 1]*0.05;
robot.efector_radius = 5;
% close(1)
drawRobot(robot,  robot.bindGP, 'k', 3);
simulateRobotFi(robot, robot.bindGP)
 figure(1)
 %%
% axis([-1000 2100 -1500 1500 -1000 2100])
xlabel('[mm]');
ylabel('[mm]');
% view([20 45])
zlabel('[mm]');

%%
% rysujemy pionowy przekrój:

a6 = a3+a4+a5;

o1 = [a2 0 a1 1];
o2 = [a2 0 a1+1000 1];
% drawPoint3d(o1)
% drawPoint3d(o2)
hold on
arc1 = [];
for fi = pi*3/2 : 0.01 : 2*pi
    arc1 = [arc1;
        o1 + a6*[cos(fi) 0 sin(fi) 0]
    ];
end
a = arc1(1,:);
b = arc1(end,:);
drawPath3d(arc1, 'b', 2);
arc1 = [];
for fi = pi/2 : -0.01 : 0
    arc1 = [arc1;
        o2 + a6*[cos(fi) 0 sin(fi) 0]
    ];
end
c = arc1(1,:);
d = arc1(end,:);

drawPath3d(arc1, 'b', 2);
% drawLine3d(a,c, 'b', 2);
drawLine3d(b,d, 'b', 2);


%% poziomo:
o3 = [a2+a3 0 a1 1];
% drawPoint3d(o3);
arc1 = [];
for fi = pi/2 : -0.01 : 0
    arc1 = [arc1;
        o3 + (a4+a5)*[cos(fi) sin(fi) 0 0]
    ];
end

for fi = 2*pi : -0.01 : 3/2*pi
    arc1 = [arc1;
        o3 + (a4+a5)*[cos(fi) sin(fi) 0 0]
    ];
end

drawLine3d(arc1(1,:), o3, 'b', 2);
hold on
drawLine3d(arc1(end,:), o3, 'b', 2);
drawPath3d(arc1, 'b', 2);
a = arc1(1,:);
b = arc1(end,:);

o3 = [a2+a3 0 a1+1000 1];
% drawPoint3d(o3);
arc1 = [];
for fi = pi/2 : -0.01 : 0
    arc1 = [arc1;
        o3 + (a4+a5)*[cos(fi) sin(fi) 0 0]
    ];
end

for fi = 2*pi : -0.01 : 3/2*pi
    arc1 = [arc1;
        o3 + (a4+a5)*[cos(fi) sin(fi) 0 0]
    ];
end

drawLine3d(arc1(1,:), o3, 'b', 2);
drawLine3d(arc1(end,:), o3, 'b', 2);
drawPath3d(arc1, 'b', 2);
c = arc1(1,:);
d = arc1(end,:);
drawLine3d(a,c, 'b', 2);
drawLine3d(b,d, 'b', 2);


%% 
% pts = {};
hold on
tmp = [];
-pi-22*pi/180
0:-0.01:-pi;
for k = 0
for i = 0:0.01:pi/2
    gp = [0 i k 0];
    tmp = [tmp;simulateRobotFi(robot, gp)];
end
end
drawPath3d(tmp);
%%
pts{end+1} = tmp;
%%
a = pts{1}(end,:);
hold on
b = pts{2}(end,:);
c = pts{3}(end,:);
d = pts{6}(end,:);
drawLine3d(a,b, 'b', 2);
drawLine3d(b,c, 'b', 2);
drawLine3d(a,d, 'b', 2);
drawLine3d(c,d, 'b', 2);
%%
for i = 1:1:length(pts)
    drawPath3d(pts{i}, 'b', 2);
end