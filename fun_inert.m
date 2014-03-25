function [J,m]=fun_inert(wsp,R,J1)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2009 r
% Department:               KRIM AGH
% .........................................................................
% Function to determine matrix of inertial for each joint.
% Syntax [J,m]=fun_inert(wsp,R,J1)
%
% Input data:
% wsp - matrix include position of centre of gravity each
% elements of manipulator relative local coordinates system.
% R - (0,1)-vector where:
% 1 - denote prismatic joint
% 0 - denote concentrated mass
% J1 - if first joint is revolve have to provide date about inertial of
% moment first joint ralative axis revolve.
%
% Output data:
% J - matrix includes tensor intertial 
% m - vector symbols of mass each element 
% .........................................................................

%%
s=length(R);        % okreslenie ilosci tensorow bezwladnosci
J=cell(1,s);          % stwrzenie macierzt komorkowej
m=sym(zeros(1,s));
for i=1:s
    m(i)=sym(strcat('m',num2str(i)));    % stworzenie symboli mas
end

for i=1:s
    if (i==1) && (J1~=0)
        J{1}=[J1/2,0,0,0;
              0,J1/2,0,0;
              0,0,J1/2,0;
              0,0,0,m(i)];
    else 
        if R(i)==0
        Jx=m(i)*(wsp(i,2)^2+wsp(i,3)^2);
        Jy=m(i)*(wsp(i,1)^2+wsp(i,3)^2);
        Jz=m(i)*(wsp(i,1)^2+wsp(i,2)^2);
        elseif R(i)==1
        Jx=1/3*m(i)*(2*(sqrt(wsp(i,2)^2+wsp(i,3)^2)))^2;
        Jy=1/3*m(i)*(2*(sqrt(wsp(i,1)^2+wsp(i,3)^2)))^2;
        Jz=1/3*m(i)*(2*(sqrt(wsp(i,1)^2+wsp(i,2)^2)))^2;
        end
    
        J{i}=[(-Jx+Jy+Jz)/2,0,0,m(i)*wsp(i,1);
            0,(Jx-Jy+Jz)/2,0,m(i)*wsp(i,2);
            0,0,(Jx+Jy-Jz)/2,m(i)*wsp(i,3);
            m(i)*wsp(i,1),m(i)*wsp(i,2),m(i)*wsp(i,3),m(i)];
     end
end

end
        
        

