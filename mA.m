function [A5]=mA(th,d,a,al)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Determine of homogeneouse transformation matrix with aid the
% Denavit-Hartenberg notation
% Syntax A=mA(th,d,a,al)
% 
% Input data:
% th - angle of rotation round axis Z
% d - translation along axis Z
% a - translation along axis X
% al - angle of rotation round axis X
%
% Output data:
% A - homogeneous transformation matrix
% A=Rotz(al)*Traz(d)*Trax(a)*Rotx(al);
%
% .........................................................................

%%
% digits(6);
A1=rotz(sym(th));
A2=traz(sym(d));
A3=trax(sym(a));
A4=rotx(sym(al));
A5=A1*A2*A3*A4;
% A5=vpa(A5);
end