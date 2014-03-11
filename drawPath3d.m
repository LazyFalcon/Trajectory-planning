function hold = drawPath3d(path, str, gr)
% Description
% .........................................................................
% Autor:                    Karol Wajs
% Date updating:            23.01.2014 r
%
% .........................................................................
% 
% 
% 
% 
%
% Input data:
% path - punkty u³ozone wierszami
% 
% 
% 
% 
% 
% Output data:
% uchwyt do narysowanego obiektu
% 
% .........................................................................

%%
    if nargin<2
       str='b';
       gr=0.5;
    elseif nargin<3
        gr=0.5;
    end
    
    hold = plot3(path(:,1), path(:,2), path(:,3), str,'LineWidth',gr);
end