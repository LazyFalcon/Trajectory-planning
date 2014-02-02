function w=fun_omega(zmie,T)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2008 r
% Department:               KRIM AGH
% .........................................................................
% Obliczenie prêdkoœci k¹towych chwytaka
% .........................................................................

%%
p=length(T);

w0=0;
omg=zeros(1,p-1);
for i=1:p-1
    omg(i)=sym(strcat('w',num2str(i)));
    
    if zmie(i,1)==1
        b=T{1,i}(1:3,3);
	elseif zmie(i,2)==1
        b=[0;0;0];
	elseif zmie(i,3)==1
        b=[0;0;0];
	elseif zmie(i,4)==1
        b=T{1,i}(1:3,1);
    end
    w=zeros(3,p-1);
    w(:,i)=w0+b*omg(i);
    w0=w(:,i);
end



        
