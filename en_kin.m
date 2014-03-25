function [K2]=en_kin(J,vz,gp,zmie)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2009 r
% Department:               KRIM AGH
% .........................................................................
% Function to determine the kinetic energy.
% Syntax K=en_kin(J,vz,gp,zmie)
%
% Input data:
% J - matrix includes tensor intertial 
% vz - vector of instantaneous velocities each of joints
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row.
%
% Output data:
% K - vector with determine function or value kinetic energy for x, y, z
% axis.
% .........................................................................

%%
s=length(vz);
wb=waitbar(0,'calculate kinetic enegry');
K=0;
K2=sym(zeros(1,s));
for i=1:s
    U=fun_dTe(gp,zmie,i);
    for j=1:i
        for k=1:i
            K1=0.5*trace(U{j}*J{i}*(U{k})')*vz(j)*vz(k);
            K=K+K1;
        end
    end
    K2(i)=K;
    K=0;
    waitbar(i/s,wb);
end
close(wb)
end