function [S]=sum_a1(U,v,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Sumowanie iloczynu U(jk)*v(k)
% sum_a1(U,v,nr), skladnia wywolania funkcji
% .........................................................................

%%
SS=zeros(4);                % stworzenie macierzy zerowej o wymiarach 4x4
    for k=1:nr                   % rozpoczecie petli do sumowania
            S=simple(SS+U{k}*v(k));        % sumowanie kolejnych iloczynow
                SS=S;                   % przypisanie wartosci sumy do SS
    end                         % koniec petli