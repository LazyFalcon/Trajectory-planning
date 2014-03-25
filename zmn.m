function Q=zmn(zmie)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% ..........................................................................
% Function to create matrix Q depending on how variable in transformation
% from one to second coordinate system on the basis of zmie matrix is.
% Syntax Q=zmn(zmie)
%
% Input data:
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row. 
%
% Output data:
% Q - cell matrix
% ..........................................................................

%%
x=size(zmie,1);                                                               % We check size of the matrix for quantify variable 
Q=cell(1,x);                                         % to create matrix cell where we another matrix save
for i=1:x                                           % begin loop
    if zmie(i,1)==1                                 % If this cell is equal 1 then varible rotation is round Z axis
        Q{i}=[0,-1,0,0;1,0,0,0;0,0,0,0;0,0,0,0];    
    elseif zmie(i,2)==1                             % If this cell is equal 1 then varible translation is along Z axis
        Q{i}=[0,0,0,0;0,0,0,0;0,0,0,1;0,0,0,0];  
    elseif zmie(i,3)==1                             % If this cell is equal 1 then varible translation is along X axis
        Q{i}=[0,0,0,1;0,0,0,0;0,0,0,0;0,0,0,0];     
    elseif zmie(i,4)==1                             % If this cell is equal 1 then varible rotation is round X axis
        Q{i}=[0,0,0,0;0,0,-1,0;0,1,0,0;0,0,0,0];  
    else
        disp('Blad !!')
        break     % no date available
    end
end 

end