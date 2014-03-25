function ac=fun_accel_c(gp,zmie,wsp,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.09.2011 r
% Department:               KRIM AGH
% .........................................................................
% syntax: a=fun_accel_c(gp,zmie,wsp,nr)
%
% Recursive algorithm for computation the translational acceleration of
% center of mass a link express in local frame. 
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems:
% 1 - variable parameter
% 0 - constant parameter
% It can be only one 1 in row.
% wsp - coordinate mass center with respect to local coordinate system
% nr - number of link which translational acceleration is
% computation.
% If nr = 0, in result they will be translational accelerations for all
% link
%
% Output data:
% ac - vector with translational acceleration coordinate system or matrixe
% with translational accelerations with column.
%
%..........................................................................
if nargin<4 || isempty(nr), nr=0; end
if nargin<3 || isempty(wsp)
    disp('Matrix "wsp" are incorrect or not defined')
end

lp=size(wsp,1);
if nr>lp
    disp('Number of link exceed the amount of links or matrix "wsp" are incorrect')
    ac=[];
else
    
    a=fun_accel2(gp,zmie,0);
    ep=fun_epsilon(gp,zmie,0);
    w=fun_omega(gp,zmie,0);
    T=fun_Te(gp,zmie);
    ac=sym(zeros(4,lp));
    
    for i=1:lp
        al=T{1,i+1}(1:3,1:3)'*a(1:3,i);
        wl=T{1,i+1}(1:3,1:3)'*w(1:3,i);
        epl=T{1,i+1}(1:3,1:3)'*ep(1:3,i);
        ac(1:3,i)=cross(epl(1:3),wsp(i,1:3)')+cross(wl(1:3),cross(wl(1:3),wsp(i,1:3)'))+al(1:3);
        %     ac(1:3,i)=simplify(aci);
    end
    
    if nr~=0
        ac=ac(:,nr);
    end
end

end


