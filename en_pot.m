function P=en_pot(m,g,gp,zmie,wsp)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2009 r
% Department:               KRIM AGH
% .........................................................................
% Function for determinate potential energy.
% Syntax: P=en_pot(m,g,gp,zmie,wsp)
%
% Input data:
% m - the vector mass of elements
% g - defines where is direction of gravitational force in basic coordinates
% system
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row. 
% wsp - matrix where we have coordinates center of mass in line express in
% element
%
% Output data:
% P - vector with determine function or value potential energy for x, y, z
% axis.
% .........................................................................

%%
T=fun_Te(gp,zmie);
s=length(m);
wb=waitbar(0,'calculate potential enegry');
% P1=cell(1,s);
P=sym(zeros(1,s));
for i=1:s
    P(i)=-m(i)*g*(T{1,i+1}*wsp(i,:)');
    waitbar(i/s,wb);
end
close(wb)

end
