% in: path, robot, shapes
% out: fixed path, or if not, bad parts 
nodes = input3D(5);
%%
% nodes = [
%    348    3  600    1;
%   249  119  526    1;
%   353  226  570    1;
%   400  -53  339    1;
%   198   77  456    1;
%   388 -176  203    1
% ];
% nodes(end,:)=input3D
     for i = 1:1:length(nodes)
         hold on
         drawPoint3d(nodes(i,:), 'ko',2);
     end
    %%
         axis([-100 650 -475 250 -10 700])
     view([-45 45])
    xlabel('mm');
    ylabel('mm');
    zlabel('mm');
     for i = 1:1:length(shapes)
%         drawCollShape(shapes{i});
    end
%%
    path = SplineInterpolation(nodes);
%     path = BSpline(nodes);
   handle = drawPath3d(path, 'k', 2);
%%
    hold on
    fixedPath = FixWholePath(robot, fixedPath{1}, shapes);
    %%
%     figure(2)
hold on
handle = drawPath3d(path, 'k', 1);
% handle = drawPath3d(path(fixedPath{2}{1},:), 'r', 2);
handle = drawPath3d(fixedPath{1}, 'k', 2);
%%
handle = drawPath3d(path(fixedPath{2}{2},:), 'r', 2);
%%
LEGEND('punkty kontrolne','trasa pocz¹tkowa', 'strefy kolizji', 'trasa poprawiona')


%%    
 resp = computeGP(robot, fixedPath{1}, 1, 0.01, 250, true);
 gps = resp{1};
 bad_indices = resp{2};
 %% 
      clc
velc = computeVelocities(robot, gps, 20, true);
  %%
  gps_oriented =    computeGPOriented(robot, fixedPath{1}, [0 0 -1 0], 15, 0.1, 500, true);
  