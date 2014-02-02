[x,y,z] = sphere;      %# Makes a 21-by-21 point sphere
r = 100;  
xu = r.*x(11:end,:);       %# Keep top 11 x points
yu = r.*y(11:end,:);       %# Keep top 11 y points
zu = r.*z(11:end,:);       %# Keep top 11 z points
% 
xd = r.*x(1:11,:);       %# Keep top 11 x points
yd = r.*y(1:11,:);       %# Keep top 11 y points
zd = r.*z(1:11,:);       %# Keep top 11 z points


               %# A radius value
% surf(x,y,z);  %# Plot the surface
% axis equal;
%% 
% hold on
% mesh(x,y,z,'EdgeColor','blue')
axis([-300 650 -300 650 -300 650])
%% wyciagamy punkty

points_up = [];
points_down = [];
for i = 1:1:11
    for j = 1:1:21
        points_up = [points_up; [xu(i,j) yu(i,j) zu(i,j) 1]];
        points_down = [points_down; [xd(i,j) yd(i,j) zd(i,j) 1]];
    end
end

%% teraz obracamy punkty i odsuwamy
p1 = [0 -0 0 1];
p2 = [100 0 100 1];
vec = w_normalize(p2 -p1);
hold on
drawLine3d(p1*(-1), p2*2)

%% wyznaczamy uk³ad wspó³zednych
    if isequal(vec, [0 0 1 0])
        xp = [1 0 0 0];
        yp = [0 1 0 0];
        zp = [0 0 1 0];
    else
        planeXY = [0 0 1 0];
        dist = w_dot(planeXY, vec);

        zp = w_normalize(vec - [0 0 -1 0]*dist)
        zp = vec;
        yp = [w_normalize(w_cross([0 0 1 0], zp)) 0]

        xp = [w_normalize(w_cross(vec, yp)) 0]

        out = [xp; yp;vec];
    end
drawLine3d(p1*(-1), p1+zp*150, 'r',2)
 
    %% macierz transformacji
    transform = [xp;yp;zp;[0 0 0 1]]'
%     transform = [xp',yp',zp',[0 0 0 1]']'
    
%     b1 = transform*[50 0 0 1]';
% drawPoint3d(b1,'k+')
    %% 
    
    %wyciagamy
points_up = [];
points_down = [];
for i = 1:1:11
    for j = 1:1:21
        points_up = [points_up; [xu(i,j) yu(i,j) zu(i,j) 1]];
        points_down = [points_down; [xd(i,j) yd(i,j) zd(i,j) 1]];
    end
end
%     transformujemy wszystkie punkty
for i = 1:1:length(points_up)
    point = transform*points_up(i,:)';
    points_up(i,:) = point' ;
end

for i = 1:1:length(points_down)
    point = transform*points_down(i,:)';
    points_down(i,:) = point' ;
end

%%
x1 = zeros(11,21);
y1 = zeros(11,21);
z1 = zeros(11,21);

x2 = zeros(11,21);
y2 = zeros(11,21);
z2 = zeros(11,21);
it = 0;
for i = 1:1:11
    for j = 1:1:21
        it = it+1;
        x1(11 - i +1,j) = points_up(it,1);
        y1(11 - i +1,j) = points_up(it,2);
        z1(11 - i +1,j) = points_up(it,3);
        
        x2(11 - i +1,j) = points_down(it,1);
        y2(11 - i +1,j) = points_down(it,2);
        z2(11 - i +1,j) = points_down(it,3);
    end
end
%% robimy cylinder
j = 1;
xc  = zeros(2,21);
yc = zeros(2,21);
zc= zeros(2,21);

for i = 1:1:21
    xc(i,j) = x2(1,i);
    yc(i,j) = y2(1,i);
    zc(i,j) = z2(1,i);
end
j = 2;
for i = 1:1:21
    xc(i,j) = x1(1,i);
    yc(i,j) = y1(1,i);
    zc(i,j) = z1(1,i);
end

%% rysujemy
% mesh(x1,y1,z1)
% set(hSurface,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% hold on
% mesh(x2,y2,z2)
% mesh(xc,yc,zc)
hSurface =  surface([x1; x2],[y1; y2],[z1; z2])
set(hSurface,'FaceColor',[1 0 0],'FaceAlpha',0.5,'EdgeAlpha', 1);

