function Mn=change(M,lp)  
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            30.10.2011 r
% Department:               KRIM AGH
% .........................................................................
% The function to change phrase from syms notation to char notation in
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
if nargin < 2 || isempty(lp), lp=6; end

l=char(M); 
h  = strrep(l,'*','.*');
h1 = strrep(h,'^','.^');
h2 = strrep(h1,'/','./');
h3 = strrep(h2,'PI','pi');

for i=1:lp
    
    qzt=strcat('q',num2str(i));
    vzt=strcat('vz',num2str(i));
    azt=strcat('az',num2str(i));
    xtt=strcat('xt',num2str(i));
    vtt=strcat('vt',num2str(i));
    att=strcat('at',num2str(i));
       
    h4 = strrep(h3,qzt,xtt);
    h5 = strrep(h4,vzt,vtt);
    h3 = strrep(h5,azt,att);

end

Mn=h3;

end
