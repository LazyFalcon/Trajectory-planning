function a=fun_accel2(gp,zmie,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.09.2011 r
% Department:               KRIM AGH
% .........................................................................
% syntax: a=fun_accel2(gp,zmie,nr)
%
% Recursive algorithm for computation the translational acceleration of a
% coordinate system with respetc to global coordinate system.
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems:
% 1 - variable parameter
% 0 - constant parameter
% It can be only one 1 in row.
% nr - number of coordinate system which translational acceleration is
% computation.
% If nr = 0, in result they will be translational accelerations for all
% coordinates systems.
%
% Output data:
% a - vector with translational acceleration coordinate system or matrixe
% with translational accelerations with column.
%
%..........................................................................
if nargin<3 || isempty(nr), nr=0; end

T=fun_Te(gp,zmie);
lp=size(T,2);

if nr>lp-1
    disp('Number of coordinate system exceed the amount of local coordinate systems ')
    a=[];
else
    
    a0=[0;0;0;0];
    w=fun_omega(gp,zmie,0);
    ep=fun_epsilon(gp,zmie,0);
    a=sym(zeros(4,lp-1));
    al=sym(zeros(1,lp-1));
    vl=sym(zeros(1,lp-1));
    for i=1:lp-1
        al(i)=sym(strcat('az',num2str(i)));
        vl(i)=sym(strcat('vz',num2str(i)));
        p=T{1,i+1}(:,4)-T{1,i}(:,4);
        
        if zmie(i,2)==1
            b=T{1,i}(:,3);
        elseif zmie(i,1)==1 || zmie(i,4)==1
            b=[0;0;0;0];
        elseif zmie(i,3)==1
            b=T{1,i}(:,1);
        end
        
        a(1:3,i)=a0(1:3)+cross(ep(1:3,i),p(1:3))+cross(w(1:3,i),cross(w(1:3,i),p(1:3)))+al(i)*b(1:3)+cross(2*w(1:3,i),vl(i)*b(1:3));
        a0=a(:,i);
        
    end
    
    if nr~=0
        a=a(:,nr);
    end
    
end
end