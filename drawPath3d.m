function hold = drawPath3d(path, str, gr)
    %rysuje trajektorê w 3d, na podstawie kolejnych punktów(vectory 4elementowe),
    if nargin<2
       str='b';
       gr=0.5;
    elseif nargin<3
        gr=0.5;
    end
    
    hold = plot3(path(:,1), path(:,2), path(:,3), str,'LineWidth',gr);
end