function [z,zmie]=fun_var(zmie)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2009 r
% Department:               KRIM AGH
% .........................................................................
% This function checks if there are any translation without variable in the
% matrix "zmie". If there are then modify the construction of the matrix
% "zmie".
% Syntax [z,zmie]=fun_var(zmie)
%
% Input data:
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row.
% 
% Output data:
% z - 1 denote it was change, 0 denote it wasn't change
% zmie - old or new matrix after the change
% .........................................................................

%%
x=size(zmie,1);
if sum(zmie(x,:))<1
    zmie(x,:)=[];
    z=1;
else
    z=0;
end

end