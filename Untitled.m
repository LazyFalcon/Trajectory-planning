%rzeczy do pracy:
%% bezier:
    w = [0 0.5 1];
    str = {'-', '-.', '--'};
    t = 0:0.01:1;
    axis([-0.5 4.5 -0.5 4.5])
    for i = 1:1:3
        bez = [0 0 0 1; 0 3 0 w(i); 4 3 0 1];
        points = bezier3(bez, t, 2);
        hold on
        drawPath3d(points,str{i},1);
    end
    legend('0', '0.5', '1');
    %%  rysunek pokazuj¹cy krzyw¹ nieci¹g³¹ i krzyw¹ ci¹g³¹
    path = InitPath(robot);
    path{end}.point = [0 0 0 1];
    path = Line(path, [10 100 0 1], 2, 25);
    path = Line(path, [100 101 0 1], 2, 25);
    result = SmoothPath(path, 0.2);
    drawPath3d(result,' k',2);
    drawLine3d([0 0 0 1], [10 100 0 1], 'k-.', 2);
    drawLine3d([10 100 0 1], [100 101 0 1], 'k-.', 2);
    axis([-0.5 110 -0.5 110])
    
    p = [7.5124   75.1241         0    1.0000;
   10.0000  100.0000         0    2.0000;
   34.9985  100.2778         0    1.0000];
    drawPoint3d(p(1,:), 'o',2);
    drawPoint3d(p(2,:), '+',2);
    drawPoint3d(p(3,:), 'o',2);


    legend('wyg³adzony', 'nie wyg³adzony', 'punkty interpolowane', 'punkt kontrolny');
    %% rysunek pokazuj¹cy nie- i przesiany zbiór punktów
    path = InitPath(robot);
    path{end}.point = [0 0 0 1];
    path = Line(path, [10 100 0 1], 2, 25);
    path = Line(path, [100 101 0 1], 2, 25);
    result = SmoothPath(path, 0.001);
    
    figure(1)
    drawPath3d(result,' k.',0.5);
    axis([-0.5 110 -0.5 110])
    legend('przed');
    
    figure(2)
    result = SmoothPath(path, 3);
    drawPath3d(result,' k.',0.5);
    axis([-0.5 110 -0.5 110])
    legend('po');
    
    %% taki manipulator z przy³o¿on¹ si³¹
    gp = [0 -15 30 0 0 60 0]*pi/180;
    drawRobot(robot,gp);
    axis([-200 800 -200 800 -200 1000])
    point = [200   0  300 1];
    response = jacobi_IK(robot, gp, point, 0.05, 500);
    gp = response{1};
    
    drawRobot(robot, gp, '--');
    %% bezier 4
    
    w = [0 0.5 1];
    str = {'-', '-.', '--'};
    t = 0:0.01:1;
        bez = [
            0 1 0 1; 
            1 0.6 0 2; 
            0 0 0 0.4;
            1 0 0 1
            ];
        points = bezier4(bez, t, 3);
        hold on
        drawPath3d(points, 'k',1);