function Mn=change_simulink(M,lp)  
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            30.10.2011 r
% Department:               KRIM AGH
% .........................................................................
% Function for changes phrase from syms notation to char notation in
% artmetic equation. It uses for dynamic equation where the variables are:
% - coordinate joint ( change qn to xtn )
% - velocity joint ( change vzn to vtn )    
% - acceleration joint ( change azn to atn ) 
% where n is the index of joint. 
% Syntax Mn=change(M,lp)
% 
% Input data:
% M - equasion for a change
% lp - amount of joints
%
% Output data:
% Mn - equation after change
%
% Excample
% M=cos(q1)*cos(q2)*vz1^2*az2
% 
% Mn=change(M,2)
% 
% Mn=cos(xt1).*cos(xt2).*vt1.^2.*at2
%
% .........................................................................

l=char(M); 
% h  = strrep(l,'*','.*');
% h1 = strrep(h,'^','.^');
% h2 = strrep(h1,'/','./');
h3 = strrep(l,'PI','pi');

for i=1:lp
    
    Mt=strcat('M',num2str(i));
    qzt=strcat('q',num2str(i));
    vzt=strcat('vz',num2str(i));
    
    Mtt=strcat('u(',num2str(i),')');
    qtt=strcat('u(',num2str(i)+lp,')');
    vtt=strcat('u(',num2str(i)+2*lp,')');
       
    h4 = strrep(h3,Mt,Mtt);
    h5 = strrep(h4,qzt,qtt);
    h3 = strrep(h5,vzt,vtt);

end

Mn=h3;

end
