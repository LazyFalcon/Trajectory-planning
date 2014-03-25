function vl=fun_speed(gp,zmie,vz,nr,pw)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Function to determines velocity of point relative to the base definite in
% local coordinate system.
% Syntax vl=fun_speed(gp,zmie,vz,nr,pw)
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems:
% 1 - variable parameter
% 0 - constant parameter
% It can be only one 1 in row.
% nr - number of coordinate system
% vz - vector of instantaneous velocities each of joints
% pw - vector definites coordinates in nr coordinate system ( default
% p=[0;0;0;1] )
%
% Output data:
% vl - vector with determine function or value velocities for x, y, z
% axis.
% .........................................................................

%%
if nargin < 5 || isempty(pw), pw=[0;0;0;1]; end
if nargin < 4 || isempty(nr), nr=sum(zmie(:)); end
if nargin < 3 || isempty(vz),
    warndlg('Data Error for fun_speed')
else

lp=size(vz,2);
if nr>lp
    disp('Number of coordinate system exceed the amount of local coordinate systems or vector "vz" are incorrect')
    vl=[];
else
    
    Uik=fun_dTe(gp,zmie,nr);                            % obliczenie pochodnej Te
    x=size(zmie,1);
    z=fun_var(zmie);
    if z==1 && nr==x
        S=sum_a1(Uik,vz,nr-1);                                % sumowanie iloczynow Ujk*qqk
    else
        S=sum_a1(Uik,vz,nr);                                % sumowanie iloczynow Ujk*qqk
    end
    vl=S*pw;                                            % obliczenie predkosci
    
end
end

end