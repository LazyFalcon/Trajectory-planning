function v=fun_speed2(gp,zmie,vl,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.09.2011 r
% Department:               KRIM AGH
% .........................................................................
% syntax: v=fun_speed2(gp,zmie,vl,nr)
%
% Recursive algorithm to computation the translational velocity of a
% coordinate system
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems:
% 1 - variable parameter
% 0 - constant parameter
% It can be only one 1 in row.
% nr - number of coordinate system which translational velocity is
% computation.
% If nr = 0, in result they will be translational velocities for all
% coordinates systems.
%
% Output data:
% v - vector with translational velocity coordinate system or matrixe
% with translational velocities with column.
%
%..........................................................................

T=fun_Te(gp,zmie);
lp=size(T,2);

if nr>lp-1
    disp('Number of coordinate system exceed the amount of local coordinate systems ')
    v=[];
else
    
    v0=[0;0;0;0];
    w=fun_omega(gp,zmie,0);
    v=sym(zeros(4,lp-1));
%     vl=sym(zeros(1,p-1));
    for i=1:lp-1
        %     vl(i)=sym(strcat('vz',num2str(i)));
        p=T{1,i+1}(:,4)-T{1,i}(:,4);
        
        if zmie(i,2)==1
            b=T{1,i}(:,3);
        elseif zmie(i,1)==1 || zmie(i,4)==1
            b=[0;0;0;0];
        elseif zmie(i,3)==1
            b=T{1,i}(:,1);
        end
        
        v(1:3,i)=v0(1:3)+b(1:3)*vl(i)+cross(w(1:3,i),p(1:3));
        v0=v(:,i);
        
    end
    
    if nr~=0
        v=v(:,nr);
    end
end
end


