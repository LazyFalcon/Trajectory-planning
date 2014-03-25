function A=fun_Ai(gp)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Determine a homogeneous transformation matrices 
% Syntax A=fun_Ai(gp)
%
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations.
%
% Output data:
% A - cell matrix contains homogeneous transformation matrices between
% successive coordinate frames. 
%
% A =[[A1],[A2],[A3],...,[An]]
% 
% .........................................................................

%%
x=size(gp,1);                                    
A=cell(1,x);                                        
for i=1:x                                           
    A{1,i}=mA(gp(i,1),gp(i,2),gp(i,3),gp(i,4));     
end 

end

    
    