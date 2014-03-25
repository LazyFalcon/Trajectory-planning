function [F,M]=fun_euler(gp,zmie,wsp,m,gr,Fe,Me,I)
% syntax fun_euler(gp,zmie,wsp,m,gr,Fe,Me,I)
ac=fun_accel_c(gp,zmie,wsp);
ep=fun_epsilon(gp,zmie);
w=fun_omega(gp,zmie);
T=fun_Te(gp,zmie);
lp=size(ac,2);
ni=sym(zeros(3,lp));
mi=sym(zeros(3,lp));
g=sym(zeros(3,lp));
wt=sym(zeros(3,lp));
ept=sym(zeros(3,lp));

%% determine of a vectors m and n used to determination center of mass "i"
% relative to "i" coordinate system and "i-1" coordinate system, m and n
% are define in "i" coordinate system.

for i=1:lp
    mi(1:3,i)=(-wsp(i,1:3))';
    T1=T{i,i+1}^-1;
    ni(1:3,i)=simplify(T1(1:3,4)+mi(:,i));
    g(1:3,i)=simplify(T{1,i+1}(1:3,1:3)'*gr(1:3)');
    wt(1:3,i)=T{1,i+1}(1:3,1:3)'*w(1:3,i);
    ept(1:3,i)=T{1,i+1}(1:3,1:3)'*ep(1:3,i);
end
F=sym(zeros(1,lp));
M=sym(zeros(1,lp));

%% transformation torque and force from basic coordinate system for last
% local coordinate system
% ss=size(T,2)
Fn=simplify(T{1,end}^-1*-Fe);
Mn=simplify(T{1,end}^-1*-Me);
wb=waitbar(0,'calculate forces/moments of forces');
for i=1:lp
    F(1:3,lp+1-i)=Fn(1:3)-m(lp+1-i)*g(1:3,lp+1-i)+m(lp+1-i)*ac(1:3,lp+1-i);
    M(1:3,lp+1-i)=Mn(1:3)-cross(ni(1:3,lp+1-i),F(1:3,lp+1-i))+cross(mi(1:3,lp+1-i),Fn(1:3))+I{lp+1-i}*ept(1:3,lp+1-i)+cross(wt(1:3,lp+1-i),I{lp+1-i}*wt(1:3,lp+1-i));
    
    Fn=T{lp+1-i,lp+2-i}(1:3,1:3)*(F(1:3,lp+1-i));
%     Mn1=sym(zeros(4,1));
%     Mn1(1:3)=M{lp+1-i};
    Mn=T{lp+1-i,lp+2-i}(1:3,1:3)*(M(1:3,lp+1-i));
%     wiersz=lp+1-i
%     kolumna=lp+2-i
waitbar(i/lp,wb);
end
close(wb)
end