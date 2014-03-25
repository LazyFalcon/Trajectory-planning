function PRPep_pionowoX(D, a2, d1min, d1max, th2min, th2max, d3min, d3max, n)
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%Autor:                  Patryk Pytko
%Ostatnia aktualizacja:  29.03.2010 r
%Kierunek:               Robotyka i Automatyka, IMIR, AGH
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%Funkcja rysuje wykres meshz, b³êdu pozycji od po³o¿enia efektora dla 
%struktury CYLINDRYCZNEJ PRP w przekroju, pionow¹ plaszczyzn¹ X=D.
%
% Parametry zadane:
% D  - wspó³rzêdna X, pionowej p³aszczyzny przekroju, jed. [metry]
% a2 - d³ugoœæ drugiego cz³onu, jed. [metry]
% d1min  - dolny zakres przesuwu pierwszego cz³onu, jed. [metry]
% d1max  - górny zakres przesuwu pierwszego cz³onu, jed. [metry]
% th2min - dolny zakres k¹ta obrotu drugiego przegubu, jed. [/degree]
% th2max - górny zakres k¹ta obrotu drugiego przegubu, jed. [/degree]
% d3min  - dolny zakres przesuwu trzeciego cz³onu, jed. [metry]
% d3max  - górny zakres przesuwu trzeciego cz³onu. jed. [metry]
%
% Domyœlne wartoœci parametrów:
% D=2, a2=2, d1min=0, d1max=1, th2min=-55, th2max=55, d3min=0, 
% d3max=1, n=25
%
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%n - dok³adnoœæ z jak¹ wykreœlana bêdzie przestrzeñ
% ustawienie domyœlnej wartoœci parametrów:
if nargin < 9 || isempty(n),        n         = 25;        end
if nargin < 8 || isempty(d3max),    d3max     = 1;         end
if nargin < 7 || isempty(d3min),    d3min     = 0;         end
if nargin < 6 || isempty(th2max),   th2max    = 55;        end
if nargin < 5 || isempty(th2min),   th2min    = -55;       end
if nargin < 4 || isempty(d1max),    d1max     = 1;         end
if nargin < 3 || isempty(d1min),    d1min     = 0;         end
if nargin < 2 || isempty(a2),       a2        = 2;         end
if nargin < 1 || isempty(D),        D         = 2;         end

%warunek sprawdzaj¹cy dobrane parametry:
if (d3min < d3max && d1min < d1max && th2min < th2max)


D1=d1min : (d1max-d1min)/n : d1max; %zdefiniowanie d1
TH2=th2min*pi/180 : (th2max-th2min)*pi/180/n : th2max*pi/180; %zdefiniowanie /theta2
D3 =d3min : (d3max-d3min)/n : d3max;                      %zdefiniowanie d3

[d1,th2]  = meshgrid(D1,TH2);           %tablica /theta1 i /theta2
[t2, d3w] = meshgrid(TH2,D3);              %tablica do obliczenia warunku na zakres X1.

X1 = a2.*cos(t2) - d3w.*sin(t2);             %obliczanie wartoœci Z aby sprawdziæ zakresy min(X1) i max(X1)

if ( D <= max(X1(:)) && D >= min(X1(:)) ) %warunek sprawdzaj¹cy czy p³aszczyzna X=D przecina przestrzeñ robocz¹.

    % Z uk³adu równan: p³aszczyzny X=D i X = a2.*cos(th2) - d3.*sin(th2), obliczam d3.
     d3=(-D+a2.*cos(th2))./sin(th2); 
     
[p,q]=size(d3);     %sprawdzenie wymiaru macierzy d3 i przypisanie wartoœci do p i q.
v=0; %parametr do tworzenia tablic X(v,:,:) ...
%% Pêtla da warunku sprawdzaj¹cego czy obliczone wczeœniej d3 nale¿y do
% dziedziny czyli przedzia³u < d3min, d3max >
for i=1:p
    for j=1:q
if ( d3(i,j) < d3max) && ( d3(i,j) > d3min)
    v=v+1;

    %Symetrycznoœæ manipulatora wzglêdem osi X pozwala na rozbicie
    %przekroju na dwa p³aty, dodatni i ujemny. Mo¿na oczywiœcie zilustrowaæ
    %tylko jeden p³at.
    
    Z(v,:,:) = d1;
    [m,n]=size(d1);   % wymiary macierzy d1, aby zapisaæ macierzowo X,Y
  %  Wspó³rzêdna X struktury PRP
    %X(v,:,:) = (a2.*cos(th2(i,j)) - d3(i,j).*sin(th2(i,j))).*ones(m,n);
  %  %wspó³rzêdna X zapisana tablicowo, 
  %  Wspó³rzêdna Y struktury PRP
  %  Jeœli przestrzeñ robocza bêdzie mia³a dwa osobne przekroje to mesh
  %  jest po³¹czy w jedne i wynik nie bêdzie mia³ sensu, mogê narysowaæ dwa
  %  osobne oddzielaj¹c wartoœci dodatnie od ujemnych ale to w pêtli jest
  %  czasoch³onne. Najlepiej rozpatrywaæ tylko wartoœci dodatnie przyjmuj¹c
  %  Y1(v,:,:) jako wartoœæ bezwzglêdn¹ z Y(v,:,:).
        Y(v,:,:) = (a2.*sin(th2(i,j)) + d3(i,j).*cos(th2(i,j))).*ones(m,n);
        Y1(v,:,:) = abs((a2.*sin(th2(i,j)) + d3(i,j).*cos(th2(i,j)))).*ones(m,n);

  %wspó³rzêdna Y zapisana tablicowo liczona z przerobionego wzoru wynikowego
  %funkcji bladPRP().
    X(v,:,:) = (((1/10000*sin(1/1800*pi) + (sin(1/1800*pi)^2 - cos(1/1800*pi)^2*sin(1/1800*pi))*(1/10000*sin(899/1800*pi) + 1/10000) + (cos(1/1800*pi + th2(i,j))*(a2 + 1/10000) + 1/10000*cos(899/1800*pi)*sin(1/1800*pi + th2(i,j)))*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) + (d3(i,j) + 1/10000*sin(1/1800*pi) + 1/10000)*(cos(1/1800*pi)^2*(sin(1/1800*pi)*sin(1/1800*pi + th2(i,j)) - cos(1/1800*pi)*sin(899/1800*pi)*cos(1/1800*pi + th2(i,j))) + (sin(1/1800*pi)*cos(1/1800*pi + th2(i,j)) + cos(1/1800*pi)*sin(899/1800*pi)*sin(1/1800*pi + th2(i,j)))*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) - cos(1/1800*pi)*cos(899/1800*pi)*(sin(1/1800*pi)^2 - cos(1/1800*pi)^2*sin(1/1800*pi))) + (1/10000*cos(1/1800*pi) - 1/10000*cos(1/1800*pi)*sin(1/1800*pi))*(cos(1/1800*pi)^2*(cos(1/1800*pi)*sin(1/1800*pi + th2(i,j)) + sin(1/1800*pi)*sin(899/1800*pi)*cos(1/1800*pi + th2(i,j))) + (cos(1/1800*pi)*cos(1/1800*pi + th2(i,j)) - sin(1/1800*pi)*sin(899/1800*pi)*sin(1/1800*pi + th2(i,j)))*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) + cos(899/1800*pi)*sin(1/1800*pi)*(sin(1/1800*pi)^2 - cos(1/1800*pi)^2*sin(1/1800*pi))) + 1/10000*cos(1/1800*pi)^2 + d3(i,j)*cos(th2(i,j)) + cos(1/1800*pi)^2*(sin(1/1800*pi + th2(i,j))*(a2 + 1/10000) - 1/10000*cos(899/1800*pi)*cos(1/1800*pi + th2(i,j))) - a2*sin(th2(i,j)) + (1/10000*sin(1/1800*pi) + 1/10000*cos(1/1800*pi)^2)*(sin(899/1800*pi)*(sin(1/1800*pi)^2 - cos(1/1800*pi)^2*sin(1/1800*pi)) + cos(899/1800*pi)*sin(1/1800*pi + th2(i,j))*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) - cos(1/1800*pi)^2*cos(899/1800*pi)*cos(1/1800*pi + th2(i,j))))^2 + (1/10000*cos(1/1800*pi) + (1/10000*sin(899/1800*pi) + 1/10000)*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) + (1/10000*sin(1/1800*pi) + 1/10000*cos(1/1800*pi)^2)*(sin(899/1800*pi)*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) + cos(899/1800*pi)*sin(1/1800*pi + th2(i,j))*(cos(1/1800*pi)^2 - sin(1/1800*pi)^3) + cos(1/1800*pi)*cos(899/1800*pi)*sin(1/1800*pi)*cos(1/1800*pi + th2(i,j))) - 1/10000*cos(1/1800*pi)*sin(1/1800*pi) - a2*cos(th2(i,j)) - d3(i,j)*sin(th2(i,j)) - (cos(1/1800*pi)*cos(899/1800*pi)*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) - (sin(1/1800*pi)*cos(1/1800*pi + th2(i,j)) + cos(1/1800*pi)*sin(899/1800*pi)*sin(1/1800*pi + th2(i,j)))*(cos(1/1800*pi)^2 - sin(1/1800*pi)^3) + cos(1/1800*pi)*sin(1/1800*pi)*(sin(1/1800*pi)*sin(1/1800*pi + th2(i,j)) - cos(1/1800*pi)*sin(899/1800*pi)*cos(1/1800*pi + th2(i,j))))*(d3(i,j) + 1/10000*sin(1/1800*pi) + 1/10000) + (cos(1/1800*pi)^2 - sin(1/1800*pi)^3)*(cos(1/1800*pi + th2(i,j))*(a2 + 1/10000) + 1/10000*cos(899/1800*pi)*sin(1/1800*pi + th2(i,j))) + (1/10000*cos(1/1800*pi) - 1/10000*cos(1/1800*pi)*sin(1/1800*pi))*((cos(1/1800*pi)*cos(1/1800*pi + th2(i,j)) - sin(1/1800*pi)*sin(899/1800*pi)*sin(1/1800*pi + th2(i,j)))*(cos(1/1800*pi)^2 - sin(1/1800*pi)^3) + cos(899/1800*pi)*sin(1/1800*pi)*(cos(1/1800*pi)*sin(1/1800*pi) + cos(1/1800*pi)*sin(1/1800*pi)^2) - cos(1/1800*pi)*sin(1/1800*pi)*(cos(1/1800*pi)*sin(1/1800*pi + th2(i,j)) + sin(1/1800*pi)*sin(899/1800*pi)*cos(1/1800*pi + th2(i,j)))) - cos(1/1800*pi)*sin(1/1800*pi)*(sin(1/1800*pi + th2(i,j))*(a2 + 1/10000) - 1/10000*cos(899/1800*pi)*cos(1/1800*pi + th2(i,j))))^2 + (1/10000*sin(1/1800*pi) + sin(1/1800*pi)*(sin(1/1800*pi + th2(i,j))*(a2 + 1/10000) - 1/10000*cos(899/1800*pi)*cos(1/1800*pi + th2(i,j))) - (1/10000*sin(1/1800*pi) + 1/10000*cos(1/1800*pi)^2)*(cos(899/1800*pi)*sin(1/1800*pi)*cos(1/1800*pi + th2(i,j)) - cos(1/1800*pi)^2*sin(899/1800*pi) + cos(1/1800*pi)*cos(899/1800*pi)*sin(1/1800*pi)*sin(1/1800*pi + th2(i,j))) - (cos(1/1800*pi)^3*cos(899/1800*pi) - sin(1/1800*pi)*(sin(1/1800*pi)*sin(1/1800*pi + th2(i,j)) - cos(1/1800*pi)*sin(899/1800*pi)*cos(1/1800*pi + th2(i,j))) + cos(1/1800*pi)*sin(1/1800*pi)*(sin(1/1800*pi)*cos(1/1800*pi + th2(i,j)) + cos(1/1800*pi)*sin(899/1800*pi)*sin(1/1800*pi + th2(i,j))))*(d3(i,j) + 1/10000*sin(1/1800*pi) + 1/10000) + cos(1/1800*pi)^2*(1/10000*sin(899/1800*pi) + 1/10000) + (1/10000*cos(1/1800*pi) - 1/10000*cos(1/1800*pi)*sin(1/1800*pi))*(sin(1/1800*pi)*(cos(1/1800*pi)*sin(1/1800*pi + th2(i,j)) + sin(1/1800*pi)*sin(899/1800*pi)*cos(1/1800*pi + th2(i,j))) + cos(1/1800*pi)^2*cos(899/1800*pi)*sin(1/1800*pi) - cos(1/1800*pi)*sin(1/1800*pi)*(cos(1/1800*pi)*cos(1/1800*pi + th2(i,j)) - sin(1/1800*pi)*sin(899/1800*pi)*sin(1/1800*pi + th2(i,j)))) - cos(1/1800*pi)*sin(1/1800*pi)*(cos(1/1800*pi + th2(i,j))*(a2 + 1/10000) + 1/10000*cos(899/1800*pi)*sin(1/1800*pi + th2(i,j))) + 1/10000)^2)^(1/2)).*ones(m,n);

end
    
    end 
end
%figure(1)
%plot3k({Z(:),Y1(:),X(:)});

X1=reshape(X,v,size(Y,2)*size(X,3));  %zmiana wymiaru tablicy X ( x3) na x2, aby móg³ j¹ obs³u¿yæ mesh
Y1=reshape(Y1,v,size(Y,2)*size(Y1,3));  % -- || --
Z1=reshape(Z,v,size(Y,2)*size(Z,3));  % -- || -- 

%% Wykreœlanie bry³y metod¹ mesh.
%figure(2)
h=meshz(Y1,Z1,X1);
colormap cool;
%whitebg('w');
light('Style','infinite');
lighting gouraud;
rotate3d;
shading interp;
grid on;
set(gca,'FontName','Arial','FontSize',10,'FontWeight','bold');
xlabel('po³o¿enie Y [m]')
ylabel('po³o¿enie Z [m]')
zlabel('B³¹d pozycji e_{p} [m]')

title('Wizualizacja b³êdu pozycji e_{p} struktury PRP, w przekroju p³aszczyzn¹ pionow¹ X=D')
%view([-133,33,90])
set(h,'SpecularColorReflectance',1,'AmbientStrength',0.5,'EdgeColor',...
'none','facecolor', 'interp','LineStyle','none','FaceLighting','gouraud');
hold on


%% B³êdy dla wprowadzonych z³ych parametrów.
else
    error('P³aszczyzna X nie przecina siê z przestrzeni¹ robocz¹, "D" musi byæ z przedzia³u <%d,%d> \n',min(X1(:)),max(X1(:)))

end
         else
   error('Wartoœci d3min i d3max, th2min, th2max oraz th1min, th1max s¹ Ÿle dobrane: \n Musz¹ byæ spe³nione warunki: d3min<d3max, th2min<th2max, th1min<th1max \n Twoje wartoœci: d3min=%d, d3max=%d, th2min=%d, th2max=%d, th1min=%d, th1max=%d \n',d3min,d3max,th2min,th2max, th1min, th1max)

end