
t = 0:0.001:1; 

bez = [
    0 1;
    0 1;
    1 10;
    0 10;
];


% drawPath3d(bez, 'ko');
% hold on
po = bezierN(bez, t);
% drawPath3d(po, 'k.');
plot(t, po(:,1) , 'k')
% hold off
grid

% view([0 90])


