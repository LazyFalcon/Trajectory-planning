function [A]=mAe(th,d,a,al,eth,ed,ea,eal,efi,eb)
% autor: Patryk Pytko
% Tworzy macierz transformacji uk³adu, uwzglêdniaj¹c b³êdy: mAe(th,d,a,al,eth,ed,ea,eal,efi,eb)
A1=rotz(th+eth);
A2=traz(d+ed);
A3=trax(a+ea);
A4=rotx(al+eal);
A5=roty(efi);
A6=tray(eb);
A=A1*A2*A3*A4*A5*A6;
