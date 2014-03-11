function hold = drawPoint3d(point, str, gr)
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
% points
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
       str='bo';
       gr=0.5;
    elseif nargin<3
        gr=0.5;
    end
    
    hold = plot3(point(1), point(2), point(3) , str,'LineWidth',gr);
end