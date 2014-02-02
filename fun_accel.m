function a=fun_accel(gp,zmie,nr,pw,vz,az)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Function to determines acceleration of point relative to the base
% definite in local any coordinate system.  
% Syntax a=fun_al(gp,zmie,nr,pw,vz,az)
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
% pw - vector definites coordinates in nr coordinate system
% vz - vector of instantaneous velocities each of joints
% az - vector of instantaneous accelerations each of joints
%
% Output data:
% a - vector with determine function or value acceleration for x, y, z
% axis.
% .........................................................................

%%
Uik=fun_dTe(gp,zmie,nr);                 % obliczenie pochodnej Te
Uikm=fun_ddTe(gp,zmie,nr);               % obliczenie drugiej pochodnej Te
[x]=size(zmie,1);
[z]=fun_var(zmie,1);
if z==1 && nr==x
S1=sum_a2(Uikm,vz,nr-1);                   % sumowanie odpowiednich iloczynow 
S2=sum_a3(Uik,az,nr-1);                   % sumowanie odpowiednich iloczynow
else
S1=sum_a2(Uikm,vz,nr);                   % sumowanie odpowiednich iloczynow 
S2=sum_a3(Uik,az,nr);                   % sumowanie odpowiednich iloczynow
end
S=simple(S1+S2);                                % dodanie otrzymanych wynikow
a=S*pw;                                 % obliczenie przyspieszenia