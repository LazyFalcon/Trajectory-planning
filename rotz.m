function [rz]=rotz(th)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
%..........................................................................
% The Calculation of matrix rotation round axis Z
% Syntax rz=rotz(th)
% 
% Input data
% th - value of rotation
%
% Output data:
% rz - matrix of rotation relative Z axis.
%
%     [ cos(th),-sin(th), 0 , 0 ]
%     [ sin(th), cos(th), 0 , 0 ]
%     [    0   ,    0   , 1 , 0 ]
%     [    0   ,    0   , 0 , 1 ]
%..........................................................................

%% 
rz=[cos(th),-sin(th),0,0;sin(th),cos(th),0,0;0,0,1,0;0,0,0,1];

end