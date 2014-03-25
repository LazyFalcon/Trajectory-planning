function [F,M]=euler(gp,zmie,wsp,nr)
ac=fun_accel_c(gp,zmie,wsp,nr)
T=fun_Te(gp,zmie);
lp=size(T,2)-1;
ni=cell(1,lp);
mi=cell(1,lp);
g=cell(1,lp);
for i=1:lp
    mi{i}=(-wsp(i,:))';
    mi{i}(4)=0;
    T1=T{i,i+1}^-1;
    ni{i}=simplify(T1(:,4)+m{i});
    ni{i}(4)=0;
    g{i}=simplify(T{1,i+1}^-1*gr);
end
F=cell(1,lp);1

for i=1:lp
    F{lp+1-i)=Fe-m{lp+1-i)*



    