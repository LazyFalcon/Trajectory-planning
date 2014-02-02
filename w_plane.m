function out=w_plane(p1, p2, p3)
%    wyznaczanie równania p³aszczyzny, postaci vektora (ABCD)
    v1=(p2-p1);
    v2=(p3-p2);
    
    
    v1=w_normalize(p2-p1);
    v2=w_normalize(p3-p2);
    normal=w_normalize(w_cross(v1,v2));
    d=-w_dot(normal, p2(1:3));
    out=[normal, d];
end