function out = XXX_MR_computeq4(T03, T0e)
     r03t = T03(1:3,1:3)';
     r0e = T0e(1:3,1:3)';

    que = single(r03t/r0e);

    out = atan2(que(2,1), que(1,1));
end