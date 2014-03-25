function [T]=funt(A)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% Function to create of cell square matrix includes each possible kTj
% transformations matrices from k ( k=1,2,3,...,n ) to j ( j=1,2,3,...,n )
% coordinate system subject to k<j, where n is the number the last
% coordinate system.
% Syntax [T]=funt(A)
% 
% Input data:
% A - cell matrix inlcudes successive matrices transformation.
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
y=size(A,2);                              % okreslenie dlugosci macierzy A
T=cell(y+1,y+1);                            % stworzenie macierzy komorkowej
% wb=waitbar(0,'calculate tranformations matrices');
for k=1:y+1                                 % rozpoczecie pierwszej petli, ktorej licznik bedzie okreslal wiersz macierzy T.
    Tk=eye(4);                              % stworzenie macierzy z jedynkami na przekatnej glownej
    for n=1:y+1                             % poczatek drugiej petli, ktorej licznik bedzie okreslal kolumny macierzy T. 
        if n<k                              % instrokcja warunkowa, jezeli licznik wiersza jest wiekszy od licznika kolumn zostanie wykonana instrukcja pod nia
            T{k,n}=0;                       % przypisanie 0 do danej komorki, gdyz komorki
        elseif n==k                         % kolejny warunek, ktory jest sprawdzany w momecie nie spelnienia pierwszego
            T{k,n}=[sym(1),0,0,0;0,sym(1),0,0;0,0,sym(1),0;0,0,0,sym(1)];                  % przypisanie macierzy jednostkowej,
        else                                % jezeli zaden poprzedni warunek nie byl spelniony to zostanie wykonana instrukcja ponizej
%             T{k,n}=simple(Tk*A{1,n-1});
            T{k,n}=Tk*A{1,n-1};     % wyliczenie iloczynu macierzy i przypisanie do komorki macierzy.
%             T{k,n}=Tk*A{1,n-1};
            Tk=T{k,n};                      % przypisanie macierzy z okreslonej komorki do Tk, ktory bedzie wykorzystany w kolejnym zapetleniu.
        end                                 % koniec instrukcji warunkowej
    end                                     % koniec drugiej petli
%     waitbar(k/(y+1),wb);
end      
% close(wb)
% koniec pierwszej petli

end
    