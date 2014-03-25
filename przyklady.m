clc
clearvars
% clear all
% Model geometryczny
syms q1 q2 q3 q4 q5 real
a2=0.5;
a3=0.3;
d6=0.25;
gp=[q1,0,0,0;...
    0,q2,a2,-pi/2;...
    q3,0,a3,-pi/2;...
    q4,0,0,0;...
    0,0,0,q5;...
    0,d6,0,0];
zmie=[1,0,0,0;...
    0,1,0,0;...
    1,0,0,0;...
    1,0,0,0;...
    0,0,0,1;...
    0,0,0,0];
s2r=pi/180;
r2s=180/pi;
% % Przyjmowanie parametrów do macierzy transformacji
% T=fun_Te(gp,zmie);
% T0e=T{1,6};
% Tj=cell(1,6);
% Tj{1}=subs(T{1,6},{q1,q2,a2,q3,a3,q4,q5,d6},{-180*pi/180,0.6,0.5,90*pi/180,0.3,90*pi/180,90*pi/180,0.25});
% Tj{2}=subs(T{1,6},{q1,q2,a2,q3,a3,q4,q5,d6},{-45*pi/180,0.75,0.5,30*pi/180,0.3,70*pi/180,50*pi/180,0.25});
% Tj{3}=subs(T{1,6},{q1,q2,a2,q3,a3,q4,q5,d6},{0*pi/180,0.89,0.5,0*pi/180,0.3,0*pi/180,0*pi/180,0.25});
% Tj{4}=subs(T{1,6},{q1,q2,a2,q3,a3,q4,q5,d6},{30*pi/180,1.1,0.5,-20*pi/180,0.3,-35*pi/180,-40*pi/180,0.25});
% Tj{5}=subs(T{1,6},{q1,q2,a2,q3,a3,q4,q5,d6},{90*pi/180,0.8,0.5,40*pi/180,0.3,-70*pi/180,-50*pi/180,0.25});
% Tj{6}=subs(T{1,6},{q1,q2,a2,q3,a3,q4,q5,d6},{130*pi/180,0.6,0.5,70*pi/180,0.3,-90*pi/180,-90*pi/180,0.25});
% 
% A=fun_Ai(gp);
% T0eu=zam(zmie,T0e);
% T03=A{1}*A{2}*A{3};

% T03=A{1}*A{2}*A{3};
% p03=T03(1:3,4);
% p03u=zam(zmie,p03);
% q=cell(1,6);
% for j=1:6
%     
% % kinematyka odwrotna
% pw=Tj{j}(1:3,3)*d6;
% pa=Tj{j}(1:3,4)-pw;
% 
% % wyznaczenie pierwszej wspolrzednej
% q11=atan2(pa(2),pa(1));
% q11s=q11*r2s;
% 
% n=2;
% 
% % wyznaczenie trzeciej wspolrzednej
% if abs(roundn((pa(2)-sin(q11)*a2)/(sin(q11)*a3),-5))<=1
% if abs(q11-pi/2)<=0.001 || abs(q11+pi/2)<=0.001
%     q31(1)=roundn(acos((pa(2)-sin(q11)*a2)/(sin(q11)*a3)),-5);
%     q31(2)=roundn(-acos((pa(2)-sin(q11)*a2)/(sin(q11)*a3)),-5);
%     if q31(1)==q31(2)
%         n=1;
%     end
% else
%     q31(1)=roundn(acos((pa(1)-cos(q11)*a2)/(cos(q11)*a3)),-5);
%     q31(2)=roundn(-acos((pa(1)-cos(q11)*a2)/(cos(q11)*a3)),-5);
%     if q31(1)==q31(2)
%         n=1;
%     end
% end
% q31s=q31*180/pi;
% 
% % wyznaczenie drugiej wspó³rzêdnej
% for i=1:n
%     q21(i)=pa(3)+sin(q31(i))*a3;
% end
% 
% % sprawdzanie zakresów ruchów i spe³nienia warunków zadania
% % zakresy ruchu
% zr=[-180*s2r,0.5999,-110*s2r;180*s2r,1.1001,110*s2r];
% 
% % przygotowanie kombinacji rozwi¹zañ
% t1=q11;
% t2=q21;
% t3=q31;
% 
% % wyznaczenie pa
% paw=T03(1:3,4);
% for i=1:n
%     pas(:,i)=subs(paw,{q1,q2,q3,'a2','a3'},{t1,t2(i),t3(i),0.5,0.3});
% end
% 
% % dpax dpay dpaz powinny byc rowne 0
% for i=1:n
%     dpax(i)=pa(1)-pas(1,i);
%     dpay(i)=pa(2)-pas(2,i);
%     dpaz(i)=pa(3)-pas(3,i);
% end
% qr=[];
% qs=[];
% % sprawdzanie zakresu ruchów i zapis wyników
% m=1;
% for i=1:n
%     if zr(1,1)<=t1 && t1<=zr(2,1) && zr(1,2)<=t2(i) && t2(i)<=zr(2,2) && zr(1,3)<=t3(i) && t3(i)<=zr(2,3) && abs(dpax(i))<=0.0001 && abs(dpay(i))<=0.0001 && abs(dpaz(i))<=0.0001
%         qr(m,:)=roundn([q11 q21(i) q31(i)],-5);
%         qs(m,:)=roundn([q11*r2s q21(i) q31(i)*r2s],-5);
%         m=m+1;
%     end
% end
% qqr{j}=qr;
% qqs{j}=qs;
% else
%     disp('Blad')
%     
% end
% end
% 
% T03=A{1}*A{2}*A{3};
% T3e=A{4}*A{5}*A{6};
% R36=T3e(1:3,1:3);
% R03=T03(1:3,1:3);
% R03w=cell(1,6);
% R0e=cell(1,6);
% for i=1:6
%     R0e{i}=Tj{i}(1:3,1:3);
%     R03w{i}=subs(R03,{q1,q2,q3,'a2','a3'},{qqr{i}(1,1),qqr{i}(1,2),qqr{i}(1,3),0.5,0.3});
%     R3eq{i}=R03w{i}'*R0e{i};
%     qq4(i)=roundn(atan2(R3eq{i}(2,1),R3eq{i}(1,1))*r2s,-5);
%     qq5(i)=roundn(atan2(R3eq{i}(3,2),R3eq{i}(3,3))*r2s,-5);
% end

% close all
% 
% % planowanie trajektorii
Q1=[-180,-45,0,30,90,130]*s2r;
Q2=[0.6,0.75,0.89,1.1,0.8,0.6];
Q3=[90,30,0,-20,40,70]*s2r;
Q4=[90,70,0,-35,-70,-90]*s2r;
Q5=[90,50,0,-40,-50,-90]*s2r;
%  
% zadanie czasu prêdkoœci i przyœpieszenia pocz¹tkowego i koñcowego, obie wartoœci przyjmujemy jako 0.
V=[0 0];
A=[0 0];
T1=[0.39,0.28,0.27,0.34,0.28];
% 
% zaplanowanie trajektorii 555
% wywo³anie wykresów przemieszczenia, prêdkoœci, przyspieszenia
y1=fun_path(Q1,T1,V,A);
y2=fun_path(Q2,T1,V,A);
y3=fun_path(Q3,T1,V,A);
y4=fun_path(Q4,T1,V,A);
y5=fun_path(Q5,T1,V,A);

% wykresy przemieszczenie, prêdkoœci i przyspieszenia.
[xt1,vt1,at1,t]=fun_graph(y1,T1,0.001,'red',[],zmie,2,1);
[xt2,vt2,at2,t]=fun_graph(y2,T1,0.001,'blue',[],zmie,2,1);
[xt3,vt3,at3,t]=fun_graph(y3,T1,0.001,'black',[],zmie,2,1);
[xt4,vt4,at4,t]=fun_graph(y4,T1,0.001,'green',[],zmie,2,1);
[xt5,vt5,at5,t]=fun_graph(y5,T1,0.001,'cyan',[],zmie,2,1);

% TT=0;
% tw(1)=0;
% figure(1)
% ww=length(T1);
% for i=1:ww
%     tw(i+1)=T1(i)+TT;
%     TT=tw(i+1);
% end
% plot(tw,Q1,'o')

s=length(vt1);


wsp=[0,0,0,1;...
    -a2,0,0,1;...
    a3/2,0,0,1;...
    0,0,0,1;...
    0,0,d6,0];

R=[0,0,1,0,0];

J=0.25;
% 
Jm=fun_inert(wsp,R,J);
%  
syms vz1 vz2 vz3 vz4 vz5 real
vz=[vz1 vz2 vz3 vz4 vz5];

K=en_kin(Jm,vz,gp,zmie);		
% 
% Kc=sum(K);
% 
% 
% close all
% 
% for i=1:s
%     Km(i)=roundn(subs(Kc,{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5,'m2','m3','m4','m5',a2,a3,d6},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i),10,6,3,5,0.5,0.3,0.25}),-5);
% end
% 
% plot(t,Km)
% title(['Wykres zaleznosci zmiany energii kinetycznej w czasie przejazdu zadana trajektoria.']);
% xlabel('Podstawa czasu [s]');
% ylabel('Zmiana energii w czasie [J]');

% [J,ms]=fun_inert(wsp,R,J);
% 
% g=[0,0,-9.81,0]
% 
% syms az1 az2 az3 az4 az5
% 
% az=[az1 az2 az3 az4 az5];
% 
% F=fun_F(J,ms,vz,az,g,gp,zmie,wsp);
% 
% F1=F(1);
% for i=1:s
%     f1(i)=roundn(subs(F1,{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5,'m2','m3','m4','m5',a2,a3,d6,az1,az2,az3,az4,az5},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i),10,6,3,5,0.5,0.3,0.25,at1(i),at2(i),at3(i),at4(i),at5(i)}),-5);
% end
% 
% F2=F(2);
% for i=1:s
%     f2(i)=roundn(subs(F2,{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5,'m2','m3','m4','m5',a2,a3,d6,az1,az2,az3,az4,az5},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i),10,6,3,5,0.5,0.3,0.25,at1(i),at2(i),at3(i),at4(i),at5(i)}),-5);
% end
% F3=F(3);
% for i=1:s
%     f3(i)=roundn(subs(F3,{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5,'m2','m3','m4','m5',a2,a3,d6,az1,az2,az3,az4,az5},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i),10,6,3,5,0.5,0.3,0.25,at1(i),at2(i),at3(i),at4(i),at5(i)}),-5);
% end
% F4=F(4);
% for i=1:s
%     f4(i)=roundn(subs(F4,{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5,'m2','m3','m4','m5',a2,a3,d6,az1,az2,az3,az4,az5},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i),10,6,3,5,0.5,0.3,0.25,at1(i),at2(i),at3(i),at4(i),at5(i)}),-5);
% end
% F5=F(5);
% for i=1:s
%     f5(i)=roundn(subs(F5,{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5,'m2','m3','m4','m5',a2,a3,d6,az1,az2,az3,az4,az5},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i),10,6,3,5,0.5,0.3,0.25,at1(i),at2(i),at3(i),at4(i),at5(i)}),-5);
% end
% 
% close all
% 
% figure(1)
% plot(t,f1)
% title(['Wykres zale¿noœci zmiany momentu obrotowego w czasie przejazdu zadan¹ trajektori¹ dla z³¹cza nr.1.']);
% xlabel('Podstawa czasu [s]');
% ylabel('Zmiana momentu obrotowego w czasie [Nm]');
% 
% figure(2)
% plot(t,f2)
% title(['Wykres zale¿noœci zmiany si³y w czasie przejazdu zadan¹ trajektori¹ dla z³¹cza nr.2.']);
% xlabel('Podstawa czasu [s]');
% ylabel('Zmiana si³y w czasie [N]');
% 
% figure(3)
% plot(t,f3)
% title(['Wykres zale¿noœci zmiany momentu obrotowego w czasie przejazdu zadan¹ trajektori¹ dla z³¹cza nr.3.']);
% xlabel('Podstawa czasu [s]');
% ylabel('Zmiana momentu obrotowego w czasie [Nm]');
% 
% figure(4)
% plot(t,f4)
% title(['Wykres zale¿noœci zmiany momentu obrotowego w czasie przejazdu zadan¹ trajektori¹ dla z³¹cza nr.4.']);
% xlabel('Podstawa czasu [s]');
% ylabel('Zmiana momentu obrotowego w czasie [Nm]');
% 
% figure(5)
% plot(t,f5)
% title(['Wykres zale¿noœci zmiany momentu obrotowego w czasie przejazdu zadan¹ trajektori¹ dla z³¹cza nr.5.']);
% xlabel('Podstawa czasu [s]');
% ylabel('Zmiana momentu obrotowego w czasie [Nm]');

% % wyznaczenie danych do wykresu trajektorii
% hold off
% close all
% s=length(vt1);
% figure(1)
% T06=[];
% for i=1:s
%     T06(1:3,i)=subs(T{1,6}(1:3,4),{q1,q2,q3,q4,q5,a2,a3,d6},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),0.5,0.3,0.25});
% end
% T06t=[];
% for i=1:6
%     T06t(1:3,i)=subs(T{1,6}(1:3,4),{q1,q2,q3,q4,q5,a2,a3,d6},{Q1(i),Q2(i),Q3(i),Q4(i),Q5(i),0.5,0.3,0.25});
% end
% 
% plot3(T06(1,:),T06(2,:),T06(3,:),T06t(1,:),T06t(2,:),T06t(3,:))
% grid on
% title({'Wykres 3D przemieszczenie wyznaczonej trajektorii efektora i ';'trajektorii zlozonej z odcinkow laczacych kolejne punkty'})
% xlabel('os x [m]');
% ylabel('os y [m]');
% zlabel('os z [m]');
% dt=0;
% for i=1:s-1
%     dt=dt+sqrt((T06(1,i+1)-T06(1,i))^2+(T06(2,i+1)-T06(2,i))^2+(T06(3,i+1)-T06(3,i))^2);
% end
% dt
% dt2=0;
% 
% for i=1:5
%     dt2=dt2+sqrt((T06t(1,i+1)-T06t(1,i))^2+(T06t(2,i+1)-T06t(2,i))^2+(T06t(3,i+1)-T06t(3,i))^2);
% end
% dt2
pw=[0;0;0;1];
syms vz1 vz2 vz3 vz4 vz5 az1 az2 az3 az4 az5 real
vz=[vz1 vz2 vz3 vz4 vz5];
az=[az1 az2 az3 az4 az5];
vzl=fun_speed(gp,zmie,vz,5,pw);
azl=fun_accel(gp,zmie,vz,az,5,pw);
% az2=fun_accel(gp,zmie,6,pw,vz,az);
% a1w=subs(vzl,{'q1','q2','a2','q3','a3','q4','q5','d6',vz1,vz2,vz3,vz4,vz5,az1,az2,az3,az4,az5},{-90*pi/180,0.6,0.5,90*pi/180,0.3,90*pi/180,90*pi/180,0.25,1,2,3,4,5,1,2,3,4,5})
% a2w=subs(azl,{'q1','q2','a2','q3','a3','q4','q5','d6',vz1,vz2,vz3,vz4,vz5,az1,az2,az3,az4,az5},{-90*pi/180,0.6,0.5,90*pi/180,0.3,90*pi/180,90*pi/180,0.25,1,2,3,4,5,1,2,3,4,5})
% a1w==a2w
n=length(vt1);
vn=zeros(1,n);
for i=1:n
vn(i)=subs(vzl(1),{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5},{xt1(i),xt2(i),xt3(i),xt4(i),xt5(i),vt1(i),vt2(i),vt3(i),vt4(i),vt5(i)});
end
% a1w=subs(vzl,{'q1','q2','q3','q4','q5','vz1','vz2','vz3','vz4','vz5','az1','az2','az3','az4','az5'},{xt1,xt2,xt3,xt4,xt5,vt1,vt2,vt3,vt4,vt5,at1,at2,at3,at4,at5})
% a2w=subs(azl,{'q1','q2','q3','q4','q5','vz1','vz2','vz3','vz4','vz5','az1','az2','az3','az4','az5'},{xt1,xt2,xt3,xt4,xt5,vt1,vt2,vt3,vt4,vt5,at1,at2,at3,at4,at5})
vnch1=change(vzl(1));
vnch=eval(vnch1);

vn1=subs(vzl(1),{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5},{xt1,xt2,xt3,xt4,xt5,vt1,vt2,vt3,vt4,vt5});
vn2=subs(vzl(2),{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5},{xt1,xt2,xt3,xt4,xt5,vt1,vt2,vt3,vt4,vt5});
vn3=subs(vzl(3),{q1,q2,q3,q4,q5,vz1,vz2,vz3,vz4,vz5},{xt1,xt2,xt3,xt4,xt5,vt1,vt2,vt3,vt4,vt5});
figure
plot(t,vnch,'-.b')
hold on
plot(t,vn(1,:),'.r')
hold off


