function ddTe=fun_ddTe(gp,zmie,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008
% Department:               KRIM AGH
% .........................................................................
% Function to determine second derivative of transformation matrix Te 
% syntax ddTe=fun_ddTe(gp,zmie,nr)
%
% Input data:
% gp - matrix contain in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% nr - number of coordinate system to which is the transformation from zero
% coordinate system
%
% Output data:
% ddTe - second derivative of transformation matrix
% .........................................................................

%%
T=fun_Te(gp,zmie);                   % tworzenie macierzy przeksztalcen T
x=size(zmie,1);
[z,zmie1]=fun_var(zmie);                % weryfikacja macierzy zmie dla wykorzystania jej dalej do wytowrzenia Q.
Q=zmn(zmie1);                    % obliczenie macierzy Q dla kolejnych zmiennych
U=fun_u2(T,Q);                  % tworzenie drugiej pochodnej Te
if z==1 && nr==x
    ddTe=U{nr-1};                      % wybor kolomny ktora nas interesuje
else
    ddTe=U{nr};                         
end

end