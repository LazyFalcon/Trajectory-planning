function [U]=fun_u1(T,Q)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Funkcja wyznaczajaca dT/dq, dzieki zaleznosci algebraicznej. 
% fun_u1(T,Q), skladnia wywolania funkcji.
% .........................................................................

%%
y=size(Q,2);                          % sprawdzenie ilosci zmiennych                                       
U=cell(1,y);                            % utworzenie macierzy komorkowej do ktorej beda przypisywane wyniki                                        
for k2=1:y                              % poczatek pierwszej petli
    U1=cell(k2,1);                      % utworzenie macierzy komorkowej
    kk=k2+1;                            % utworzenie zmiennej pomocniczej
    for k1=1:k2                         % poczatek pierwszej petli                 
    U1{k1,1}=T{1,k1}*Q{k1}*T{k1,kk};    % obliczanie U z odpowiedniej zaleznosci                      
    end                                 % koniec drugiej petli                                
    U{1,k2}=U1;                         % zapisanie wyniku do komorki macierzy
end                                     % koniec pierwszej petli

end