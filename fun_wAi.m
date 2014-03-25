function A=fun_wAi(A,zmie)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% This function checks if there are last translation without variable in the
% matrix "zmie". If there are then modify the construction of the matrix
% "A".
% Syntax A=fun_wAi(A,zmie)
%
% Input data:
% A - homogeneous transformation matrices
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row. 
%
% Output data:
% A - homogeneous transformation matrices
%..........................................................................

%%
y=size(A,2);
x=size(zmie,1);
if sum(zmie(x,:))<1
    A{y-1}=A{y-1}*A{y};
    A(y)=[];
end

end

    