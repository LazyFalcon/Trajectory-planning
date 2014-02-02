function caps = Capsule(pa, pb, radius)
    caps.r = radius;
    caps.p1 = pa;
    caps.p2 = pb;
    caps.center = (pa + pb)/2;
    caps.type = 'capsule';
    caps.sph_r = w_distance(pa, pb)/2 + radius/2;
end