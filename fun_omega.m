function w=fun_omega(gp,zmie,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.09.2011 r
% Department:               KRIM AGH
% .........................................................................
% syntax: w=fun_omega(gp,zmie,nr)
%
% Recursive algorithm for computation the angular velocity of a coordinate
% system.
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems:
% 1 - variable parameter
% 0 - constant parameter
% It can be only one 1 in row.
% nr - number of coordinate system which angular velocity is computation.
% If nr = 0, in result they will be angular velocities for all coordinates
% systems.
%
% Output data:
% w - vector with angilar velocity coordinate system or matrixe with
% angular velocities with column.
%
%..........................................................................
if nargin < 3 || isempty(nr), nr=0; end

T=fun_Te(gp,zmie);
lp=size(T,2);

if nr>lp-1
    disp('Number of coordinate system exceed the amount of local coordinate systems ')
    w=[];
else
    
    w0=[0;0;0;0];
    omg=sym(zeros(1,lp-1));
    w=sym(zeros(4,lp-1));
    for i=1:lp-1
        omg(i)=sym(strcat('vz',num2str(i)));
        
        if zmie(i,1)==1
            b=T{1,i}(:,3);
        elseif zmie(i,2)==1 || zmie(i,3)==1
            b=[0;0;0;0];
        elseif zmie(i,4)==1
            b=T{1,i}(:,1);
        end
        %     w=zeros(3,p-1);
        w(:,i)=w0+b*omg(i);
        w0=w(:,i);
    end
    
    if nr~=0
        w=simplify(w(:,nr));
    else
        w=simplify(w);
    end
end
end




