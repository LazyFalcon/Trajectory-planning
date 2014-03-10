function [tx]=trax(x)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% The Calculation of matrix translation along axis X
% Syntax tx=trax(x)
%
% Input data:
% x - value of translation
%
% Output data:
% tx - matrix of translation relative X axis.
%
% [ 1 , 0 , 0 , x ]
% [ 0 , 1 , 0 , 0 ]
% [ 0 , 0 , 1 , 0 ]
% [ 0 , 0 , 0 , 1 ]
%
% .........................................................................

%%
tx=[1,0,0,x;0,1,0,0;0,0,1,0;0,0,0,1];

end
