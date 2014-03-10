function [rx]=rotx(al)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
%..........................................................................
% The Calculation of matrix rotation round axis X
% Syntax rx=rotx(al)
% 
% Input data
% al - value of rotation
%
% Output data:
% rx - matrix of rotation relative X axis.
% 
%    [ 1 ,   0   ,    0   , 0 ]
%    [ 0 ,cos(al),-sin(al), 0 ]
%    [ 0 ,sin(al), cos(al), 0 ]
%    [ 0 ,   0   ,    0   , 1 ]
%
%..........................................................................

%%
rx=[1,0,0,0;0,cos(al),-sin(al),0;0,sin(al),cos(al),0;0,0,0,1];

end
