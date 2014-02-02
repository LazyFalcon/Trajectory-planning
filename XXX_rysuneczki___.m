%% arbot z wektorem
arbot = genEmptyRobot();
a1 = 150;
a2 = 100;
a3 = 100;
a4 = 50;
% [Rx Tx Tz Rz], 0 jesli wartoœæ jest sta³a, 1 jeœli jest zmienna, max
% jedna 1

arbot = addMatrice(arbot,  pi/2,0, a1, 0, [0,0,1,0]);
arbot = addMatrice(arbot,  0,a2, 0, 0, [0,0,0,1]);
arbot = addMatrice(arbot,  0,a3, 0, 0, [0,0,0,1]);
arbot = addMatrice(arbot,  0,a4, 0, 0, [0,0,0,1]);

% wartoœæ wyjœciowych wspó³¿ednych z³aczowych
arbot.bindGP = [0 60 -20 0]*pi/180;

arbot.initialPosition = [0 0 0 0];
arbot.min = [-170000 -100 -29  -90]*pi/180;
arbot.max = [17000 135 256 90]*pi/180;
arbot.max_v = [50 0.15 0.15 0.15];
arbot.max_a = [10 0.6 0.6 0.6];
arbot.efector_radius = 5;
figure(1)
drawRobot(arbot, arbot.bindGP,'k',3, 'none');
axis([-10 250 -10 10 -10 400])
view([0 0])
xlabel('mm');
ylabel('mm');
zlabel('mm');
title('rys. 3.2, wirtualna si³a dzia³aj¹ca na efektor')
p1 = simulateRobotFi(arbot, arbot.bindGP);

p2 = [200 0 200 1];

q2 = jacobi_IK(arbot, arbot.bindGP, p2);
figure(1)
q2 = q2{1};
drawRobot(arbot, q2,'k--',3, 'none');
arrow(p1(1:3)- [50 0 -50] ,p1(1:3))
p = p1(1:3)- [50 0 -50]/2 ;
text(p(1), 0, p(3),'   F','HorizontalAlignment','left','FontSize',13);
p = p2;
text(p(1), 0, p(3),'   {x}_{c}','HorizontalAlignment','left','FontSize',13);
%% arbot do DH d³ugoœci cz³onów
arbot.bindGP = [0 0 0 0]*pi/180;
drawRobot(arbot, arbot.bindGP,'k',2, 'none');
axis([-10 350 -10 10 -10 350])
view([0 0])
xlabel('mm');
ylabel('mm');
zlabel('mm');
% title('rys. 3.1, model prêtowy robota z zaznaczonymi d³ugoœciami cz³onów')
w = simulateRobotFi2(arbot, arbot.bindGP);
k=1;
p = (w(k,:) + w(k+1,:))/2;
text(p(1), 0, p(3),'   A1 = 150mm','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, p(3),'   A2 = 100mm','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, p(3),'   A3 = 100mm','HorizontalAlignment','left','FontSize',10);
k=k+1;
p = w(k,:)-(w(k,:) - w(k+1,:))/3 + [0 0 25 0];
text(p(1), 0, p(3),'     A4 = 50mm','HorizontalAlignment','left','FontSize',10);


hFig = figure(1);
set(hFig, 'Position', [100 100 450 300])
%% do DH 3.2 LUW


arbot.bindGP = [0 0 0 0]*pi/180;
drawRobot(arbot, arbot.bindGP,'k',1, 'first');
axis([-10 350 -10 10 -10 260])
view([0 0])
xlabel('mm');
ylabel('mm');
zlabel('mm');
% title('rys. 3.2, model prêtowy robota z zaznaczonymi LUW');


hFig = figure(1);
set(hFig, 'Position', [100 100 400 300])
%% przyk³adowa krzywa beziera trzeciego stopnia

bez = [
    0.5 0.5 0 1;
    6 3 0 1;
    5 6 0 1;
    2 6 0 1;
];
t = 0:0.01:1;

pts = bezier4(bez, t, 3);
drawPath3d(pts, 'k',2);
hold on
drawPath3d(bez, 'ks',2);
view([0 90])

axis([0 8 0 8 -10 260])
set(hFig, 'Position', [100 100 400 300])
xlabel('[-]');
ylabel('[-]');
zlabel('[-]');
%% przyk³adowy NURBS 
nurbs = [
    0.5 0.5 0 1;
    7 2 0 1;
    7 7 0 1;
    4 6 0 1;
    1 4 0 1;
    1 2 0 1;
];
hold on
path = NURBS(nurbs);
% drawPath3d(path,'k',2);
view([0 90])

axis([0 8 0 8 -10 260])
%% trasa z odcinków
close(1)
figure(1)
points23 = [
    50 0 350 1;
    150 0 330 1;
    
    350 0 255 10;
    350 0 150 0.5;
    
    100 0 150 1
]; 
pathStruct = InitPath(arbot);
pathStruct{end}.point  = points23(1,:);
pathStruct = Line(pathStruct, points23(2,:), 2);
pathStruct = Arc(pathStruct, points23(3,:),points23(4,:));
pathStruct = Line(pathStruct, points23(5,:), 2);



path = SmoothPath(pathStruct);
path = NURBS(points23);
path = SplineInterpolation(points23);

drawPath3d(path, 'k',2);
hold on
drawPath3d(points23, 'ks');
drawPath3d(points23, 'k.');
drawPath3d(points23, 'k--',1);

set(hFig, 'Position', [100 100 400 300])
xlabel('[-]');
ylabel('[-]');
zlabel('[-]');
view([0 0])
axis([0 475 0 400 75 400])
%% kszta³ty kolizyjne robota
close(1)
figure(1)
  arbot.shape = {};
   arbot.shapeDelay = {};
 zero = [0 0 0 1];
 x = [1 0 0 0];
 y = [0 1 0 0];
 z = [0 0 1 0];
 a = OOBB(zero, zero+x*a1, 0, 15, 15);
    arbot = addCollShape(arbot,a, [0 0 0 0]);
 a = OOBB(zero -x*(a2), zero, 0, 15, 15);
    arbot = addCollShape(arbot,a, [0 0 0 0]*90);
 a = OOBB(zero -x*(a3), zero, 0, 15, 15);
     arbot = addCollShape(arbot,a, [0 0 0 0]);
 
 a = Capsule(zero -x*(a4), zero, 7.5);
    arbot = addCollShape(arbot,a, [02 0 0 0]);
    
arbot.bindGP = [0 60 20 -50]*pi/180;
% drawRobot(arbot, arbot.bindGP ,'k',3, 'none');
 drawRobotCollShapes(arbot, arbot.bindGP );
 axis([-10 400 -200 200 -10 400])
view([0 0])
xlabel('mm');
ylabel('mm');
zlabel('mm');

%% przyk³adowy A*
% close(1)
figure(1)
shapes = {};
shapes{1} = OOBB([ 150 -150 290 1], [150 150 290 1], 0, 50,50);
shapes{2} = OOBB([ 150 -150 140 1], [150 150 140 1], 0, 50,50);

    for i = 1:1:length(shapes)
        drawCollShape(shapes{i});
    end
    
 drawRobotCollShapes(arbot, arbot.bindGP );
 axis([-10 400 -200 200 -10 400])
view([0 0])
xlabel('mm');
ylabel('mm');
zlabel('mm');

p1 = simulateRobotFi(arbot, arbot.bindGP);
p2 = [225 0 225 1];

path112 = MoveTo(arbot, p1, p2, shapes, 0.7, 15);
%%
drawPath3d(path112{2}, 'r.', 2);
%% IK
figure(1)
arbot.jointWeight = [1; 1;1.2;1.2];
arbot.jointWeight = [1; 1;1;1];
% drawRobot(arbot, arbot.bindGP,'k',3, 'none');
axis([-10 250 -10 10 -10 400])
view([0 0])
xlabel('mm');
ylabel('mm');
zlabel('mm');

p2 = [150 0 200 1];

q2 = jacobi_IK(arbot, arbot.bindGP, p2);
hold on
q2 = q2{1};
% drawRobot(arbot, q2,'k--',3, 'none');
p2 = simulateRobotFi(arbot, q2);
p = p1;
drawPoint3d(p, 'ks');
drawPoint3d(p, 'k.');
text(p(1), 0, p(3),'   {p}_{1}','HorizontalAlignment','left','FontSize',13);
p = p2;
drawPoint3d(p, 'ks');
drawPoint3d(p, 'k.');
text(p(1), 0, p(3),' {p}_{2}  ','HorizontalAlignment','right','FontSize',13);

hFig = figure(1)
xlabel('mm');
ylabel('mm');
zlabel('mm');
set(hFig, 'Position', [100 100 450 300])
axis([140 230 -10 10 190 340])

hFig = figure(2)
xlabel('[-]');
ylabel('mm');
zlabel('mm');
set(hFig, 'Position', [100 100 450 300])
%% kszta³ty kolizyjne - sfera

shapes{1} = Sphere([0 0 0 1], 10);
drawCollShape(shapes{1}, 'k');
hold on
text(0, 0, 0,'   O','HorizontalAlignment','left','FontSize',13);
text(0, 5, 0,'   R','HorizontalAlignment','left','FontSize',13);
drawPoint3d([0 0 0 1], 'ko',2);
drawLine3d([0 0 0 1], [0 10 0 1], 'k',2);
xlabel('mm');
ylabel('mm');
zlabel('mm');
view([-45 -45])
hFig = figure(1);
set(hFig, 'Position', [100 100 400 300])
%% kszta³ty kolizyjne - kapsu³a
p1= [0 0 0 1];
p2 = [20 0 0 1];
shapes{1} = Capsule(p1, p2, 10);
drawCollShape(shapes{1}, 'k');
hold on
text(0, 0, 0,'   {P}_{1} ','HorizontalAlignment','right','FontSize',13);
text(20, 0, 0,'     {P}_{2}','HorizontalAlignment','left','FontSize',13);
text(0, 7, 0,'   R','HorizontalAlignment','left','FontSize',13);
drawPoint3d(p1, 'ko',2);
drawPoint3d(p1, 'k.',2);
drawPoint3d(p2, 'ko',2);
drawPoint3d(p2, 'k.',2);
drawLine3d(p1,p2, 'k',2);

drawLine3d(p1,[0 10 0 1], 'k',2);
drawLine3d(p2,p2+w_normalize([1 -0.5 0 0])*10, 'k',2);

p = p2 + w_normalize([1 -0.5 2 0])*5;
text(p(1), p(2), p(3),'   R','HorizontalAlignment','left','FontSize',13);
xlabel('mm');
ylabel('mm');
zlabel('mm');
view([0 -45])
hFig = figure(1);
set(hFig, 'Position', [100 100 400 300])
%% kszta³ty kolizyjne - box
p1= [0 0 0 1];
p2 = [20 0 0 1];
shapes{1} = OOBB(p1,p2, 15, 15, 10);
drawCollShape(shapes{1}, 'k');
hold on
text(0, 0, 0,'   {P}_{1} ','HorizontalAlignment','left','FontSize',13);
text(20, 0, 0,'   {P}_{2}','HorizontalAlignment','left','FontSize',13);
drawPoint3d(p1, 'ko',2);
drawPoint3d(p1, 'k.',2);
drawPoint3d(p2, 'ko',2);
drawPoint3d(p2, 'k.',2);
drawLine3d(p1,p2, 'k',2);


p = [20 -5 -4];
text(p(1), p(2), p(3),'    y','HorizontalAlignment','left','FontSize',13);

p = [20 5 -4];
text(p(1), p(2), p(3),'   z','HorizontalAlignment','left','FontSize',13);
p = [10 0 0];
text(p(1), p(2), p(3),'    x','HorizontalAlignment','left','FontSize',13);
xlabel('mm, oœ X');
ylabel('mm, oœ Y');
zlabel('mm, oœ Z');
view([-45 -45])
hFig = figure(1);
set(hFig, 'Position', [100 100 400 300])
%% GP dla tej trasy - jeden przyk³adowy cz³on
% response = computeGP(arbot, path112{2},1, 0.01, 500, true);

plot(response{1}(:,2),'k','LineWidth',1.5)
xlabel('[-]');
ylabel('[rad]');

%% Trajektoria dla tej trasy - jeden przyk³adowy cz³on
vps = computeVelocities(arbot, gps, 30, true);
