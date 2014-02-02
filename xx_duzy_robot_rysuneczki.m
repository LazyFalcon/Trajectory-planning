 %% model kinematyczny 
 
hFig = figure(1);
drawRobot(robot, robot.bindGP,'k',3, 'none');
view([0 0])
axis([-10 600 -200 200 200 800])
%%
w = simulateRobotFi2(robot, robot.bindGP);
k=1;
p = [50 0 240 1];
text(p(1), p(2), p(3),'A1','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, p(3),'   A2 ','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, p(3),'A3  ','HorizontalAlignment','right','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, 720,'     A4','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, 720,'     A5','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = [ 380 0 720];
text(p(1), 0, p(3),'     A6','HorizontalAlignment','left','FontSize',10);
k=k+1;

p = [ 430 0 720];
text(p(1), 0, p(3),'     A7','HorizontalAlignment','left','FontSize',10);

%%
xlabel('[-]');
ylabel('[-]');
%%
xlabel('mm');
ylabel('mm');
zlabel('mm');
%%
axis([-100 600 -50 350 100 850])
%%
hFig = figure(1);
set(hFig, 'Position', [100 100 500 400])
% set(hFig, 'Position', [100 100 500 300])

%% trasa
points = [
    simulateRobotFi(robot, robot.bindGP);
    400 150 550 1;
    300 300 300 1;
    452 15 135 1
];

drawPath3d(points, 'k--', 2);
drawPath3d(points, 'ks', 2);
hold on
drawPath3d(NURBS(points), 'k', 2);
drawPath3d(SplineInterpolation(points), 'b', 2);
view([0 0])
axis([-10 600 -600 600 -10 800])





