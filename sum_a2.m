function [S]=sum_a2(U,v,nr)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Sumowanie iloczynu U(jkm)*v(k)*v(m)
% sum_a2(U,v,nr), skladnia wywolania funkcji
% .........................................................................
%%
SS=zeros(4);              % stworzenie macierzy zerowej o wymiarach 4x4
    for k=1:nr                 % rozpoczecie petli pierwszej
        for m=1:nr              % rozpoczecie petli drugiej
            S=simple(SS+U{m,k}*v(k)*v(m));        % sumowanie kolejnych iloczynow
                SS=S;                   % przypisanie wartosci sumy do SS
        end                     % koniec petli drugiej
    end                         % koniec petli pierwszej