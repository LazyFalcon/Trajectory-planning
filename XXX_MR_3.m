 %% interp555
 gp = gps;
 gp(:,1) = gp(:,1)/1000;
% t1 = [1 1 1 1 1 1 1]*5;
V=[0 0];
A=[0 0];


%%
% zmie = [0 1 0 0];
% t1 = [1 0.1 1 1 1 1 1]*5;
trajectory1 = fun_path(gp(:,1)', t1, V, A);
[xt1,vt1,at1,tt1,ti1] = fun_graph(trajectory1,t1,0.01,'red','-',[0 1 0 0],2,1);
%%
zmie = [0 1 0 0];
% t1 = [1 1 1 1 1 1 1]*0.2;
trajectory2 = fun_path(gp(:,2)', t1, V, A);
[xt2,vt2,at2,tt2,ti2]=fun_graph(trajectory2,t1,0.01,'red','-',[1 0 0 0],2,1);
%%d
zmie = [0 1 0 0];
trajectory3 = fun_path(gp(:,3)', t1, V, A);
[xt3,vt3,at3,tt3,ti3]=fun_graph(trajectory3,t1,0.01,'red','-',[1 0 0 0],2,1);

   %%4
zmie = [0 1 0 0];
trajectory4 = fun_path(gp(:,4)', t1, V, A);
[xt4,vt4,at4,tt4,ti4]=fun_graph(trajectory4,t1,0.01,'red','-',[1 0 0 0],2,1);
%% znajdŸ maxy na danym odcinku
% dla cz³onu pierwszego wszystkie a, maj¹ osi¹gaæ za³o¿ony max,
% zrobiæ wszystkie sprawka do niedzieli, ka¿dy punkt ma byæ w sprawku
clc
t1 = [0.15 0.2 0.15 0.15 0.2 0.2 0.2];
%%d
zmie = [0 1 0 0];
trajectory1 = fun_path(gp(:,1)', t1, V, A);
[xt1,vt1,at1,tt1,ti1] = fun_graph(trajectory1,t1,0.01,'black','-',[0 1 0 0],2,1);

zmie = [0 1 0 0];
trajectory2 = fun_path(gp(:,2)', t1, V, A);
[xt2,vt2,at2,tt2,ti2]=fun_graph(trajectory2,t1,0.01,'blue','-',[1 0 0 0],2,1);

zmie = [0 1 0 0];
trajectory3 = fun_path(gp(:,3)', t1, V, A);
[xt3,vt3,at3,tt3,ti3]=fun_graph(trajectory3,t1,0.01,'red','-',[1 0 0 0],2,1);

zmie = [0 1 0 0];
trajectory4 = fun_path(gp(:,4)', t1, V, A);
[xt4,vt4,at4,tt4,ti4]=fun_graph(trajectory4,t1,0.01,'green','-',[1 0 0 0],2,1);

ti11 = [1; ti2; length(tt2)];
max_v = [];
max_a = [];



for i=1:1:length(ti11)-1
    tmp_v = sort(abs(at2(ti11(i): ti11(i+1))) );
    tmp_a = sort(abs(vt2(ti11(i): ti11(i+1))));
%     max_v = [max_v; max(  abs(at2(ti11(i): ti11(i+1)));    abs(at1(ti11(i): ti11(i+1)))   ;abs(at3(ti11(i): ti11(i+1)))         )];
    max_a = [max_a; tmp_a(end)];
end

% max_v = max_v'
% max_a = max_a'


%% 

gp = [xt1*1000, xt2, xt3, xt4];

pts = simulateRobotFi(robot, gp);
drawPath3d(pts,'k',2)
drawPath3d(points,'k--')
%%
sum = 0;
for i =1:1:length(pts)-1
    sum = sum + w_distance(pts(i,:), pts(i+1,:));
end
sum

%%
sum = 0;
for i =1:1:length(points)-1
    sum = sum + w_distance(points(i,:), points(i+1,:));
end
sum



