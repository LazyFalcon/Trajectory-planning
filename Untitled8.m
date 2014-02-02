

figure(1)
drawRobot(robot, robot.bindGP);
axis([-1000 1000 -1000 1000 -200 1000])
hold on
%%
gps2 = MoveTo(robot, robot.bindGP, [145.1613  324.5614  352.5789 1], 0.05, 2000);
%%
tmp = jacobi_IK(robot, robot.bindGP, [145.1613  324.5614  352.5789 1], 0.05, 2000);
docelowy_gp = tmp{1};
pth = simulateRobotFi(robot, docelowy_gp)

drawRobot(robot, docelowy_gp);
%%
drawRobot(robot, gps2(end,:));
pth = simulateRobotFi(robot, gps2);
 drawPath3d(pth,' b',1);
%%
t = 0:0.01:1;
i_gp = interp1([0 1], [robot.bindGP; docelowy_gp],t,'cubic');
pth = simulateRobotFi(robot, i_gp);
 drawPath3d(pth,' b',1);