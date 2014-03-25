function [S]=sum_a3(U,a,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% This function make calculation U(jk)*a(k)
% Syntax sum_a3(U,a,nr) 
%..........................................................................
%%
SS=zeros(4);                % make the matrix with only zero.
    for k=1:nr                   % start of the loop
            S=simple(SS+U{k}*a(k));        % addition results of multiplication and save to the SS variable
                SS=S;                   
    end                         % finish of the loop
    