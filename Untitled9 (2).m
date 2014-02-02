hold on
[x,y]=meshgrid([-3,3],[-3,3]) ;
s = surf(x, y, ones(size(x)) ) ;
set(s, 'facecolor', 'b') ;
set(s,'FaceAlpha',0.5); 