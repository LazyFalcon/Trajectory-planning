function [ry]=roty(fi)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
%..........................................................................
% The Calculation of matrix rotation round axis Y
% Syntax ry=roty(fi)
% 
% Input data:
% fi - value of rotation
%
% Output data:
% ry - matrix of rotation relative Y axis.
% 
%    [ cos(fi), 0 ,sin(fi),0 ]
%    [    0   , 1 ,   0   ,0 ]
%    [-sin(fi), 0 ,cos(fi),0 ]
%    [    0   , 0 ,   0   ,1 ]
% 
%..........................................................................

%%
ry=[cos(fi),0,sin(fi),0;0,1,0,0;-sin(fi),0,cos(fi),0;0,0,0,1];

end