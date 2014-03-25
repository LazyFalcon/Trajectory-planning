function dTe=fun_dTe(gp,zmie,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Function to determine derivative dT/dq using algebra relations for nth
% joint.
% Syntax dTe=fun_dTe(gp,zmie,nr)
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row.
% nr - number of coordinate system for which derivative is to be determined
% 
% Output data:
% dTe - matrix of derivative
% .........................................................................

%%
T=fun_Te(gp,zmie);                   % wyznaczenie macierzy transformacji T
x=size(zmie,1);
[z,zmie1]=fun_var(zmie);                % weryfikacja macierzy zmie dla wykorzystania jej dalej do wytowrzenia Q
Q=zmn(zmie1);                    % obliczenie macierzy Q dla kolejnych zmiennych
U=fun_u1(T,Q);                  % otrzymane wyzej wyniki sluza do obliczenia U
if z==1 && nr==x
    dTe=U{nr-1};                      % wybor kolomny ktora nas interesuje
else
    dTe=U{nr};                         
end

end

