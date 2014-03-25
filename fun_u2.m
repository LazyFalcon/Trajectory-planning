function [U1]=fun_u2(T,Q)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Funkcja wyznaczajaca U(jkm), dzieki zaleznosci algebraicznej. 
% fun_u2(T,Q), skladnia wywolania funkcji.
%..........................................................................

%%
n=size(Q,2);                                          % sprawdzenie rozmiaru Q
U1=cell(1,n);                                           % tworzenie pierwszej macierzt komorkowej
for l=1:n                                               % poczatek pierwszej petli okreslajacej kolumne pierwszej macierzy komorkowej
    U2=cell(l,l);                                       % tworzenie drugiej macierzy komorkowej
    for k=1:l                                           % poczatek drugiej petli ktorej licznik bedzie wykorzystywany do odpowiednich wywolan, a takze okreslal wiersz w ktorym zostanie zapisany wynik  
        for m=1:l                                       % poczatek trzeciej petli ktorej licznik bedzie wykorzystywany do odpowiednich wywolan, a takze okreslal kolumne w ktorym zostanie zapisany wynik 
        if k<=m                                         % funkcja okreslajaca ktore dzialanie zostanie wykonane
            U2{k,m}=T{1,k}*Q{k}*T{k,m}*Q{m}*T{m,l+1};   % obliczenia macierzy U z zaleznsci, w przypadku zgodnosci z warunkiem k<=m
        else                                            % jezeli warunek nie zostal spelniony zostanie wykonane dzialanie ponizsze
            U2{k,m}=T{1,m}*Q{m}*T{m,k}*Q{k}*T{k,l+1};   % 
        end                                             
        end                                             % koniec trzeciej petli
    end                                                 % koniec drugiej petli
    U1{l}=U2;                                           % zapisane otrzymanych wynikow do odpowiedniej kolumny
end                                                     % koniec pierwszej petli

end