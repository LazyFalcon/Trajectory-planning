function [y1,y3,y5,tx,ti]=fun_graph(y,T,dt,col,style,zmie,width,r)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            25.04.2012 r
% Department:               KRIM AGH
% .........................................................................
% Function to plot of changes a position, a velocity and an acceleration of
% joint in a time. 
% syntax fun_graph(y,T,dt,col,style,zmie,width,r)
%
% Input data:
% y - function displacemanet (preparing with aid of fun_path function)
% T - vector with times between two points
% dt - time of digitization (default 0.001)
% col - character string for plot e.g. 'b', 'red', [0.5 0.5 0.5] (RGB)
% (default 'k')
% style - style a line of plot e.g. '-', '-.', '*', 'o' (default '-')
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row.
% width -  width of plot line (default 1)
% r - way of the mark the boundary points in plot (default 0):
% r==1 - stem function
% r~=1 - points
%
% Output data:
% xt - vector with succesive coordinates positions determined to execution
% of trajectory.
% vt - vector with succesive coordinates velocities determined to execution
% of trajectory.
% at - vector with succesive coordinates accelerations determined to
% execution of trajectory.
% t - vector with succesive time on horizontal axis plots.
% ti - numbers of cells from borders of intervals a trajectory
% 
% Exmaple:
% 
% zmie=[1 0 0 0;0 1 0 0;0 0 0 1];
% Q1=[0,0.1,0.3,0.6,1.15,1.85,2.4,2.7,2.9,3];
% T=[0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2];
% V=[0 0];A=[0 0];
% y1=fun_path(Q1,T,V,A);
% dt=0.001;
% [xt1,vt1,at1,t,ti]=fun_graph(y1,T,dt,'r','.-',zmie,2,1);
% 
%
% 25.04.2012 - added legends with units to plots
% .........................................................................

if nargin < 8 || isempty(r), r= 0; end
if nargin < 7 || isempty(width), width= 1; end
if nargin < 6 || isempty(zmie), rm= ones(10,1)*100;
else
    rm=(zmie(:,1)==1 | zmie(:,4)==1);
end
if nargin < 5 || isempty(style), style= '-'; end
if nargin < 4 || isempty(col), col= 'k'; end
if nargin < 3 || isempty(dt), dt=0.001 ; end

%%
% dt=0.0001;
% Scale the time used in interval from 0 to 1
n=length(y);
s=zeros(1,n+1);
w=cell(1,n);
lp=zeros(1,n);

for i=1:n
    s(i)=dt/T(i);
    lp(i)=ceil(T(i)/dt);
    w{i}=zeros(1,lp(i));
end
%%

t=sum(T);

tx=0:dt:t;
if tx(end)<t || abs(tx(end)-t)>=0.000000000001
    tx=[tx t];
end

sz=size(tx,2);
y1=zeros(1,sz);
y3=zeros(1,sz);
y5=zeros(1,sz);

% length(y1)
%% Create points for speed
y2=sym(zeros(1,n));
for i=1:n
    y2(i)=diff(y(i));
    y2(i)=y2(i)/T(i);
end

% length(y3)
%% Create points for acceleration
y4=sym(zeros(1,n));
for i=1:n
    y4(i)=diff(y(i),2);
    y4(i)=y4(i)/(T(i)^2);
end

%% Create points for jerk
y6=sym(zeros(1,n));
% for i=1:n
%     y6(i)=diff(y(i),3);
%     y6(i)=y6(i)/(T(i)^3);
% end

%% create points for dislocation
ti=zeros(n+1,1);
for i=1:n
    %     while w{i}(m)<1
    % %         y1(m)=subs(y(i),w);
    %         w{i}(m+1)=w{i}(m)+s(i);
    %         m=m+1;
    %         mn=mn+1;
    %     end
    
    w{i}=w{i}(1):s(i):1;
    
    if i<n
        if w{i}(end)==1
            w{i+1}(1)=s(i+1);
        else
            w2=1-w{i}(end);
            w3=(dt*w2)/s(i);
            r1=dt-w3;
            w4=(s(i+1)*r1)/dt;
            w{i+1}(1)=w4;
        end
        
    elseif (i==n) && (w{i}(end)~=1)
        lb=size(w{i},2);
        w{i}(lb+1)=1;
        %         y1(m)=subs(y(i),1);
        %         if abs(y1(m)-y1(m-1))<dt*0.001
        %             y1(m)=[];
        %         end
    end
    
    mn=size(w{i},2);
    
    yy=char(y(i));
    h  = strrep(yy,'*','.*');
    h1 = strrep(h,'^','.^');
    h2 = strrep(h1,'/','./');
    h3 = strrep(h2,'t','w{i}');
    y1((ti(i)+1):(ti(i)+mn))=eval(h3);
    
    yy2=char(y2(i));
    h  = strrep(yy2,'*','.*');
    h1 = strrep(h,'^','.^');
    h2 = strrep(h1,'/','./');
    h3 = strrep(h2,'t','w{i}');
    y3((ti(i)+1):(ti(i)+mn))=eval(h3);
    
    yy4=char(y4(i));
    h  = strrep(yy4,'*','.*');
    h1 = strrep(h,'^','.^');
    h2 = strrep(h1,'/','./');
    h3 = strrep(h2,'t','w{i}');
    y5((ti(i)+1):(ti(i)+mn))=eval(h3);
    
    %         yy6=char(y6(i));
    %         h  = strrep(yy6,'*','.*');
    %         h1 = strrep(h,'^','.^');
    %         h2 = strrep(h1,'/','./');
    %         h3 = strrep(h2,'t','w{i}');
    %         y7((ti(i)+1):(ti(i)+mn))=eval(h3);
    
    ti(i+1)=ti(i)+mn;
    
end

ti(1)=[];
ti(end)=[];

%% create vector with diferences dt

tx=sort(tx);
rtx=length(tx);
ry1=length(y1);
% ry3=length(y3);
% ry5=length(y5);

if rtx~=ry1
    y1(end)=[];
    y3(end)=[];
    y5(end)=[];
    %     y7(end)=[];
end
tx=tx';
y1=y1';
y3=y3';
y5=y5';
% y7=y7';

% ry1=length(y1);
% ry3=length(y3);
% ry5=length(y5);
% return
%% plot the graph
% global pp1 p1 legend_handle1
figure(100)
% subplot(3,1,1)
p1=plot(tx,y1,style,'color',col,'LineWidth',width);
[a1,b1,c1,e1]=legend;
ns1=size(e1,2);
% if rm(ns1+1)==1
%     ns11=strcat('joint',num2str(ns1+1),'[rad]');
% elseif rm(ns1+1)==0
%     ns11=strcat('joint',num2str(ns1+1),'[m]');
% else
    ns11=strcat('joint',num2str(ns1+1));
% end

legend([c1;p1],[e1,ns11]);
hold all
if r==1
    stem(tx(ti),y1(ti),'fill','color',col);
else
    plot(tx(ti),y1(ti),'o','color',col)
end
grid on
title('Position');
xlabel('Time [s]');
ylabel('Joint Position');


figure(200)
%subplot(3,1,2)
p2=plot(tx,y3,style,'color',col,'LineWidth',width);
[a1,b1,c2,e2]=legend;
ns2=size(e2,2);
% if rm(ns2+1)==1
%     ns22=strcat('joint',num2str(ns2+1),'[rad/s]');
% elseif rm(ns2+1)==0
%     ns22=strcat('joint',num2str(ns2+1),'[m/s]');
% else
    ns22=strcat('joint',num2str(ns2+1));
% end
legend([c2;p2],[e2,ns22]);
hold all
if r==1
    stem(tx(ti),y3(ti),'fill','color',col)
else
    plot(tx(ti),y3(ti),'o','color',col)
end
grid on
% set(gca,'XTick',tx)
title('Velocity');
xlabel('Time [s]');
ylabel('Joint Velocity');



figure(300)
%subplot(3,1,3)
p3=plot(tx,y5,style,'color',col,'LineWidth',width);
[a1,b1,c3,e3]=legend;
ns3=size(e3,2);
% if rm(ns3+1)==1
%     ns33=strcat('joint',num2str(ns3+1),'[rad/s^2]');
% elseif rm(ns3+1)==0
%     ns33=strcat('joint',num2str(ns3+1),'[m/s^2]');
% else
    ns33=strcat('joint',num2str(ns3+1));
% end
legend([c3;p3],[e3,ns33]);
hold all
if r==1
    stem(tx(ti),y5(ti),'fill','color',col)
else
    plot(tx(ti),y5(ti),'o','color',col)
end
grid on
% set(gca,'XTick',tx)
title('Acceleration');
xlabel('Time [s]');
ylabel('Joint Acceleration');
end


% figure(4)
% %subplot(3,1,3)
% plot(tx,y7,style,'color',col,'LineWidth',width);
% hold all
% stem(tx(ti),y7(ti),'fill',col)
% grid on
% % set(gca,'XTick',tx)
% title('Change jerk at time');
% xlabel('Time [s]');
% ylabel('Joint jerk');

