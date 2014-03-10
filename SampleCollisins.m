 % test kolizji scierzki z przeszkodami
%  clear all
clc
robot = genEmptyRobot();
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

robot = addMatrice(robot,  -pi/2,a2x, a2z, 0, [0,0,0,1]);
robot = addMatrice(robot,  0,a3, 0, -pi/2, [0,0,0,1]);
robot = addMatrice(robot,  0,a4, 0, 0, [0,0,0,1]);
robot = addMatrice(robot,  0,a5, 0, pi/2, [0,0,0,0]);
robot = addMatrice(robot,  0,a6, 0, 0, [1,0,0,0]);
robot = addMatrice(robot,  0,a7, 0, 0, [0,0,0,1]);
robot = addMatrice(robot,  -pi/2,a8, 0, 0, [1,0,0,0]);

% wartoœæ wyjœciowych wspó³¿ednych z³aczowych
robot.bindGP = [0 0 0 0 0 90]*pi/180;

robot.initialPosition = [0 0 203 0];
robot.min = [-170 -100 -29  -190 -120 -360 ]*pi/180;
robot.max = [170 135 256 190 120 360]*pi/180;
robot.max_v = [328 300 375 375 375 600]*pi/180;
robot.max_a = [1 1 1 1 1 1]*0.05;
robot.efector_radius = 5;
% drawRobot(robot, robot.bindGP,'k',3, 'first');
% view([0 0])
% axis([-10 600 -200 200 200 800])
 %% addCollShapes, definitywnie do dopracowania
   robot.shape = {};
   robot.shapeDelay = {};
 zero = [0 0 0 1];
 x = [1 0 0 0];
 y = [0 1 0 0];
 z = [0 0 1 0];
 a = OOBB(zero, zero+x*(sqrt(a2x^2 + a2z^2)+45), 0, 90, 90);
    robot = addCollShape(robot,a, [0 0 0 0]);
 a = OOBB(zero -x*(a3+80), zero, 0, 90, 90);
    robot = addCollShape(robot,a, [0 0 1 0]*90);
 a = OOBB(zero -x*(a4+20), zero, 0, 90, 90);
     robot = addCollShape(robot,a, [-(25 + 30) 0 0 0]);
 a = Capsule(zero -x*(a5+115), zero, 55);
    robot = addCollShape(robot,a, [-(115)/2 0 0 0]);
 a = OOBB(zero -x*a6, zero, 0, 90, 90);
     robot = addCollShape(robot,a);
 a = OOBB(zero -x*a7, zero, 0, 90, 90);
     robot = addCollShape(robot,a);
 a = OOBB(zero, zero+x*a8, 0, 60, 60);
     robot = addCollShape(robot,a);
 %%

 
%% draw bind pose
    figure(1)
robot.initialPosition = [0 0 203 0];
drawRobot(robot,  [0 0 0 0 0 90]*pi/180, 'k', 2);
% drawRobot(robot, gps_2_3{1}(50,:),'k',3, 'none');
%%0
%  close(1)
 figure(1)
axis([-3 500 -350 350 -10 940])
xlabel('mm');
ylabel('mm');
view([45 0])
zlabel('mm');
hold on
%%
robot.initialPosition = [0 0 203 0];
 drawRobotCollShapes(robot, [0 0 0 0 0 90]*pi/180);
robot.initialPosition = [600 0 203 0];
 drawRobotCollShapes(robot, [-90 0 0 0 0 90]*pi/180);
 hold on
 %% CollShapes
%  close(1)
 figure(2)
%     drawRobot(robot, robot.bindGP);
    shapes = {};
%     shapes{1} = OOBB([ 200 300 0 1], [200 300 800 1], 0, 40,40);
    shapes{end+1} = OOBB([ 500 100 600 1], [500 -400 600 1], 0, 200,10);
    shapes{end+1} = OOBB([ 500 100 300 1], [500 -400 300 1], 0, 200,10);
    
    
    shapes{end+1} = OOBB([ 500 105 700 1], [500 105 0 1], 0, 10,200);
    shapes{end+1} = OOBB([ 500 -405 700 1], [500 -405 0 1], 0, 10,200);
    
    shapes{end+1} = OOBB([ 500 -200 605 1], [500 -200 655 1], 10, 50,100);
    shapes{end+1} = OOBB([ 500 -260 605 1], [500 -260 675 1], 0, 50,100);
    
    
    shapes{end+1} = Capsule([ 400 0   330 1], [550 -300 330 1], 30);
    
    shapes{end+1} = OOBB([ -50 350 300 1], [300 350 300 1], 0, 150,10);
    shapes{end+1} = OOBB([ 305 350 400 1], [305 350 0 1], 0, 150,10);
    shapes{end+1} = OOBB([ -55 350 400 1], [-55 350 0 1], 0, 150,10);

    axis([-100 650 -400 410 -10 740])
    xlabel('mm');
    ylabel('mm');
    zlabel('mm');
    
    for i = 1:1:length(shapes)
        drawCollShape(shapes{i});
    end
%% Path

pathStruct = InitPath(robot);
pathStruct = Line(pathStruct, [500 130 541 1], 2);
pathStruct = Arc(pathStruct, [400 300 400 1],[300 150 120 1]);
pathStruct = Line(pathStruct, [400 100 590 1], 2);
pathStruct = Line(pathStruct, [500 -300 200  1], 2);

path = SmoothPath(pathStruct);
% result = generateFixedPath(robot, result, shapes);
handle = drawPath3d(path,' k',2);
points45 = [
   pathStruct{1}.point;
    500 130 541 1;
    400 300 400 1;
    300 150 120 1;
    400 100 590 1;
    500 -300 200  1
];
%%
hold on
drawPath3d(points45, 'ks');
drawPath3d(points45, 'k--',2);
%%  draw œcierzki i punktów które wpad³y w przeszkody
drawPath3d(path,' k',1);
% drawPath3d(result,' b.',1);
% drawPath3d(result(indices,:),' r.',2);


%% trochê IK
gpIndicesSpacing = 1; % sprawdamy co czwrt¹ konfiguracjê, leniwy jestem
 resp = computeGP(robot, path, gpIndicesSpacing, 0.01, 500, true);
 gps = resp{1};
 bad_indices = resp{2};
 %% draw z³ych indeksów(nieosiagalnych)
drawPath3d(path(bad_indices,:),' r.',2);
 
 %% test kolizji
 
 response = collisionTest(robot, gps, shapes);
 %% wyniki kolizji
 points_of_collison = simulateRobotFi(robot, gps(response(:,1), :));
 drawPath3d(points_of_collison,' r.',5);
 %%
  drawRobotCollShapes(robot, gps(100,:));
%% orientowanie robota w punkcie
gp_1 = Orient(robot, gps(50,:), [1 0 0 0], 0.001, 500);
figure(1)
%% narysowanie tego
drawRobotCollShapes(robot, gp_1(end,:));
drawRobot(robot, gp_1(end,:));


%%
% podpisaæ osie w mm
% uczyniæ funkce bardziej u¿ywalnymi
% zrobic teoriê, napisaæ to po ludzku