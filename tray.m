function [ty]=tray(y)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
%..........................................................................
% The Calculation of matrix translation along axis Y
% Syntax ty=tray(y)
%
% Input data:
% y - value of translation
%
% Output data:
% ty - matrix of translation relative Y axis.
% 
% [ 1 , 0 , 0 , 0 ]
% [ 0 , 1 , 0 , y ]
% [ 0 , 0 , 1 , 0 ]
% [ 0 , 0 , 0 , 1 ]
%
% .........................................................................

%%
ty=[1,0,0,0;0,1,0,y;0,0,1,0;0,0,0,1];

end
