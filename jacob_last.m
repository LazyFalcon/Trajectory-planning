function J=jacob_last(gp,zmie)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2009 r
% Department:               KRIM AGH
% .........................................................................
% This functton determine the Jacobian matrix for the first coordinate
% system.
% Syntax J=jacob_last(gp,zmie)
% 
% Input data:
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row.
% 
% Output data:
% J - Jacobian matrix
% .........................................................................

%%
if nargin < 2 | size(gp)~=size(zmie)
    warndlg('Data Error for Jacobian function')
    disp('Data Error')
    J='Data Error';
else
T=fun_Te(gp,zmie);
y=size(T,2);
J=sym(zeros(6,y-1));
wb=waitbar(0,'calculate Jacobian matrix');
for i=1:y-1;
    if zmie(i,1)==1                                
        J(1,i)=simplify(-T{i,y}(1,1)*T{i,y}(2,4)+T{i,y}(2,1)*T{i,y}(1,4));
        J(2,i)=simplify(-T{i,y}(1,2)*T{i,y}(2,4)+T{i,y}(2,2)*T{i,y}(1,4));
        J(3,i)=simplify(-T{i,y}(1,3)*T{i,y}(2,4)+T{i,y}(2,3)*T{i,y}(1,4));
        J(4,i)=T{i,y}(3,1);
        J(5,i)=T{i,y}(3,2);
        J(6,i)=T{i,y}(3,3);
    elseif zmie(i,2)==1                            
        J(1,i)=T{i,y}(3,1);
        J(2,i)=T{i,y}(3,2);
        J(3,i)=T{i,y}(3,3);
        J(4,i)=0;
        J(5,i)=0;
        J(6,i)=0;
    elseif zmie(i,3)==1                             
        J(1,i)=T{i,y}(1,1);
        J(2,i)=T{i,y}(1,2);
        J(3,i)=T{i,y}(1,3);
        J(4,i)=0;
        J(5,i)=0;
        J(6,i)=0; 
    elseif zmie(i,4)==1                             
        J(1,i)=simplify(-T{i,y}(2,1)*T{i,y}(3,4)+T{i,y}(3,1)*T{i,y}(2,4));
        J(2,i)=simplify(-T{i,y}(2,2)*T{i,y}(3,4)+T{i,y}(3,2)*T{i,y}(2,4));
        J(3,i)=simplify(-T{i,y}(2,3)*T{i,y}(3,4)+T{i,y}(3,3)*T{i,y}(2,4));
        J(4,i)=T{i,y}(1,1);
        J(5,i)=T{i,y}(1,2);
        J(6,i)=T{i,y}(1,3);
    end
    waitbar(i/(y-1),wb);
end
if isempty(symvar(J))
    J=double(J);
end
close(wb)
end

end
