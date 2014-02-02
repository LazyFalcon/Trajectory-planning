dwaPunkty = input3D(1);
%%
view([-45 30])
%%
t1= [
    526 0 652    1;
    528 40 341    1    
];
t2 = [
    528 40 341    1;
    260  347  344 1
];
drawPoint3d(t1(1,:), 'ro',3);
text(t1(1,1), t1(1,2), t1(1,3),'   \color{red}1','HorizontalAlignment','left','FontSize',13);
hold on
drawPoint3d(t2(2,:), 'ro',3);
text(t2(1,1), t2(1,2), t2(1,3),'   \color{red}2','HorizontalAlignment','left','FontSize',13);
drawPoint3d(t2(1,:), 'ro',3);
text(t2(2,1), t2(2,2), t2(2,3),'   \color{red}3','HorizontalAlignment','left','FontSize',13);
%%
path1 = MoveTo(robot, t1(1,:), t1(2, :), shapes, 0.9, 11);
%%
drawPath3d(path1{2}, 'k', 2);

%%
path2 = MoveTo(robot, t2(1,:), t2(2,:), shapes, 0.8, 9);
%%
hold on
drawPath3d(path2{2}, 'k', 2);

%% pierwszy fragment
response = jacobi_IK(robot, robot.bindGP, path1{2}(1,:), 0.01, 500);
tmp = robot.bindGP;
robot.bindGP = response{1};
 gps_1_2= computeGP(robot, path1{2}, 1 , 0.01, 500, true);
 
%% drugi fragment
response = jacobi_IK(robot, robot.bindGP, path2{2}(1,:), 0.01, 500);
tmp = robot.bindGP;
robot.bindGP = response{1};
 gps_2_3_2 = computeGPOriented(robot, path2{2}, [0 0 -1 0], 1 , 0.01, 500, true);
 
 robot.bindGP = tmp;
 %%
 drawPath3d(path2(gps_oriented{2}, :), 'r.', 2);
 
 %%
     response = jacobi_IK_oriented(robot, robot.bindGP, path2(300,:), [0 0 -1 0] , 0.01, 500);
     response{2}
    if response{2} == 0
        gp = response{1};
    end
    drawRobot(robot, gp);
    %%
    response = jacobi_IK_oriented(robot, [0 0 0 0 0 0]*pi/180, path2{2}(300,:), [0 0 -1 0], 0.01, 500);
tmp = robot.bindGP;
robot.bindGP = response{1};
 drawRobot(robot, response{1});
 %% 
 que = gps_2_3_2{1}(1:1:end,:); 
%  que = gps_1_2{1};
 vps12 = computeVelocities(robot,que, 200,  true);
 
 
 