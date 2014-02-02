function dista = w_distance2(p1, p2)
% to samo co w_distance tylko ze do ^2
    vec = p1-p2;
    dista = sum(vec.^2);
end