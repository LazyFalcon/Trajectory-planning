function [y1,y3,y5,tx,ti]=fun_graph1(y,T,sk,col,style)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            06.10.2011 r
% Department:               KRIM AGH
% .........................................................................
% Function to plot of changes a position, a velocity and an acceleration of
% joint in a time.
% syntax graph(y,T,sk,'col','style')
%
% Input data:
% y - function displacemanet
% T - vector with times between two points
% sk - time of digitization
% col - character string for plot
% style - style a line of plot
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
% .........................................................................

%% 
% sk=0.0001;
% Scale the time used in interval from 0 to 1

if nargin < 5 || isempty(style), style= '-'; end

n=length(y);
s=zeros(1,n);
for i=1:n
    s(i)=sk/T(i);
end
%%

t=sum(T);

tx=0:sk:t;
if tx(end)<t
    tx=[tx t];
end

sz=size(tx,2);
y1=zeros(1,sz);
y3=zeros(1,sz);
y5=zeros(1,sz);

%% create points for dislocation 
m=1;
w=0;
ti=zeros(n-1,1);
for i=1:n
    while w<1
        y1(m)=subs(y(i),w);
        w=w+s(i);
        m=m+1;
    end
    if i<n
        ti(i)=m;
        if w==1
            w=0;
        elseif w>1
            w1=w-s(i);
            w2=1-w1;
            w3=(sk*w2)/s(i);
            r1=sk-w3;
            w4=(s(i+1)*r1)/sk;
            w=w4;
        end
    elseif (i==n) && (w~=1)
        y1(m)=subs(y(i),1);
%         if abs(y1(m)-y1(m-1))<sk*0.001
%             y1(m)=[];
%         end
    end
end
% length(y1)
%% Create points for speed
y2=sym(zeros(1,n));
for i=1:n
    y2(i)=diff(y(i));
    y2(i)=y2(i)/T(i);
end

m=1;
w=0;
for i=1:n
    while w<1
        y3(m)=subs(y2(i),w);
        w=w+s(i);
        m=m+1;
    end
    if i<n
        if w==1
            w=0;
        elseif w>1
            w1=w-s(i);
            w2=1-w1;
            w3=(sk*w2)/s(i);
            r1=sk-w3;
            w4=(s(i+1)*r1)/sk;
            w=w4;
        end
    elseif (i==n) && (w~=1)
        y3(m)=subs(y2(i),1);
%         if abs(y3(m)-y3(m-1))<sk*0.001
%             y3
%             y3(m)=[];
%         end
    end
end
% length(y3)
%% Create points for acceleration
y4=sym(zeros(1,n));
for i=1:n
    y4(i)=diff(y(i),2);
    y4(i)=y4(i)/(T(i)^2);
end

m=1;
w=0;
for i=1:n
    while w<1
        y5(m)=subs(y4(i),w);
        w=w+s(i);
        m=m+1;
    end
    if i<n
        if w==1
            w=0;
        elseif w>1
            w1=w-s(i);
            w2=1-w1;
            w3=(sk*w2)/s(i);
            r1=sk-w3;
            w4=(s(i+1)*r1)/sk;
            w=w4;
        end
    elseif (i==n) && (w~=1)
        y5(m)=subs(y4(i),1);
%         if abs(y5(m)-y5(m-1))<sk*0.001
%             y5(m)=[];
%         end
    end
end
% length(y5)
%% create vector with diferences sk

tx=sort(tx);
rtx=length(tx);
ry1=length(y1);
% ry3=length(y3);
% ry5=length(y5);

if rtx~=ry1
    y1(end)=[];
    y3(end)=[];
    y5(end)=[];
end
tx=tx';
y1=y1';
y3=y3';
y5=y5';

% ry1=length(y1);
% ry3=length(y3);
% ry5=length(y5);

%% plot the graph
figure(1)
% subplot(3,1,1)
plot(tx,y1,style,'color',col);
hold all
stem(tx(ti),y1(ti),'fill',col)
grid on
% set(gca,'XTick',tx)
title('Wykres zaleznosci przemieszczenia od czasu.');
xlabel('Podstawa czasu [s]');
ylabel('Przemieszcznie w czasie');



figure(2)
%subplot(3,1,2)
plot(tx,y3,style,'color',col);
hold all
stem(tx(ti),y3(ti),'fill',col)
grid on
% set(gca,'XTick',tx)
title('Wykres zmiany predkosci w czasie.');
xlabel('Podstawa czasu [s]');
ylabel('Zmiana predkosci w czasie');


figure(3)
%subplot(3,1,3)
plot(tx,y5,style,'color',col);
hold all
stem(tx(ti),y5(ti),'fill',col)
grid on
% set(gca,'XTick',tx)
title('Wykres zmiany przyspieszenia w czasie.');
xlabel('Podstawa czasu [s]');
ylabel('Zmiana przyspieszenia w czasie');

end
