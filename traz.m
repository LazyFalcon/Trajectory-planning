function [tz]=traz(z)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% The Calculation of matrix translation along axis Z
% Syntax tz=traz(z)
%
% Input data:
% z - value of translation
%
% Output data:
% tz - matrix of translation relative Z axis.
% 
% [ 1 , 0 , 0 , 0 ]
% [ 0 , 1 , 0 , 0 ]
% [ 0 , 0 , 1 , z ]
% [ 0 , 0 , 0 , 1 ]
%
% .........................................................................

%%
    tz=[1,0,0,0;0,1,0,0;0,0,1,z;0,0,0,1];
    
end
