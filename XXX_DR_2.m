% macierz transformuj¹ca z 0 do e, zawiera po³o¿enie i orientacjê?
T0e = trax(Px)*tray(Py)*traz(Pz)*rotz(phi)*roty(theta)*rotx(psi);

A1 = single(mA (0.5, 2, 1, pi/2));
A2 = single(mA (0.5+pi/2, 0, 0.5, 0));
A3 = single(mA (0.5, 0, 11, pi/2));
A4 =single( mA (0.5, 1, 0, -pi/2));
A5 = single(mA (0.5, 0, 0, pi/2));
A6 =single( mA (0.5, 1, 0, 0));

R03 = A1*A2*A3;
R0e = A1*A2*A3*A4*A5*A6;

r03 = R03(1:3, 1:3)'; %odwrotnoœæ obrtotu r03
R30 = zeros(4,4);
R302 = eye(4,4);
R30(1:3, 1:3) = r03(1:3, 1:3);
R302(1:4, 4) = -R03(1:4,4);
K0 = A4*A5*A6;
K2 = R30*R0e;




