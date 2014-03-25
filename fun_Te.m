function T=fun_Te(gp,zmie)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            6.10.2010 r
% Department:               KRIM AGH
% .........................................................................
% Function to create of cell square matrix includes each possible kTj
% transformations matrices from k ( k=1,2,3,...,n ) to j ( j=1,2,3,...,n )
% coordinate system subject to k<j, where n is the number the last
% coordinate system.
% Syntax T=fun_Te(gp,zmie)
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
% T - cell matrix includes transformation matrix
%
% T=  [0T1]    [0T2]    [0T3]    [...]    [0Tn]
%     [  0]    [1T1]    [1T2]    [...]    [1Tn]
%     [  0]    [  0]    [2T2]    [...]    [2Tn]
%     [...]    [...]    [...]    [...]    [...]
%     [  0]    [  0]    [  0]    [...]    [nTn]
% .........................................................................

%%
A=fun_Ai(gp);           % obliczanie macierzy przeksztalcenia jednorodnego
wA=fun_wAi(A,zmie);     % zmiana macierzy A, w zale¿noœci czy mamy tak¹ sam¹ liczbe zmiennych co macierzy A
T=funt(wA);              % obliczenie przeksztalcen
end
