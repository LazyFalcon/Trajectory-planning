function ep=fun_epsilon(gp,zmie,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.09.2011 r
% Department:               KRIM AGH
% .........................................................................
% syntax: ep=fun_epsilon(zmie,gp,nr)
%
% Recursive algorithm for computation the angular acceleration of a
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
% nr - number of coordinate system which angular acceleration is
% computation.
% If nr = 0, in result they will be angular accelerations for all
% coordinates systems.
%
% Output data:
% ep - vector with angilar acceleration coordinate system or matrixe with
% angular accelerations with column.
%
%..........................................................................
if nargin<3 || isempty(nr), nr=0; end

T=fun_Te(gp,zmie);
lp=size(T,2);

if nr>lp-1
    disp('Number of coordinate system exceed the amount of local coordinate systems ')
    ep=[];
else
    
    e0=[0;0;0;0];
    w0=[0;0;0;0];
    w=fun_omega(gp,zmie,0);
    ep=sym(zeros(4,lp-1));
    vl=sym(zeros(1,lp-1));
    al=sym(zeros(1,lp-1));
    for i=1:lp-1
        al(i)=sym(strcat('az',num2str(i)));
        vl(i)=sym(strcat('vz',num2str(i)));
        
        if zmie(i,1)==1
            b=T{1,i}(:,3);
        elseif zmie(i,2)==1 || zmie(i,3)==1
            b=[0;0;0;0];
        elseif zmie(i,4)==1
            b=T{1,i}(:,1);
        end
        
        ep(1:3,i)=e0(1:3)+al(i)*b(1:3)+cross(w0(1:3),vl(i)*b(1:3));
        e0=simplify(ep(:,i));
        w0=simplify(w(:,i));
        
    end
    if nr~=0
        ep=simplify(ep(:,nr));
    else
        ep=simplify(ep);
    end
end

end