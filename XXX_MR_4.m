%% macierz inercji
c1 = 600;
c2 = 400;
c3 = 600;

syms m1 m2 m3 m4 real;

p = [
    0 0 0 1;
    a2/2 0 0 1;
    a3/2 0 0 1;
    0 0 0 1;
    ];
m = [
    2;
    2;
    2;
    0.5;
];

R = [
    0; 0; 0; 1;
];

[J, ms] = fun_inert(p, R,0);
%%
q = gp;
zmie = [
    0 1 0 0;
    1 0 0 0;
    1 0 0 0;
    1 0 0 0;
];
model = [
    0, d1, a1, sym(-pi/2);
    q2, 0, a2, sym(pi/2);
    q3, 0, a3, sym(-pi/2);
    q4, 0, 0, 0
];

syms vq1 vq2 vq3 vq4 real;

vq = [vq1 vq2 vq3 vq4];

K = en_kin(J, vq, model, zmie);
%%
KS = sum(K);
v = [vt1 vt2 vt3 vt4];
q = [xt1 xt2 xt3 xt4];
%%
kinet = {};
pot = {};
tmp = zeros(length(v),1);
kinet{1} = tmp;
kinet{2} = tmp;
kinet{3} = tmp;
kinet{4} = tmp;
pot{1} = tmp;
pot{2} = tmp;
pot{3} = tmp;
pot{4} = tmp;
%%
% for j = 1:1:4
for i = 1:1:length(v(:,1))
    i
    kinet{1}(i) = subs(K(1),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    kinet{2}(i) = subs(K(2),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    kinet{3}(i) = subs(K(3),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    kinet{4}(i) = subs(K(4),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    kinet{5}(i) = subs(KS,  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );

   
end
% end
%%

%%


g = [0 0 -9.81 0];
enP = en_pot(ms, g, model, zmie, p);
%%
PS = sum(enP);

for i = 1:1:length(v(:,1))
    i
    pot{1}(i) = subs(enP(1),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    pot{2}(i) = subs(enP(2),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    pot{3}(i) = subs(enP(3),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    pot{4}(i) = subs(enP(4),  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
    pot{5}(i) = subs(PS,  {d1,q2,q3,q4, a1,a2,a3, vq1,vq2,vq3,vq4, m1, m2,m3, m4},{q(i,1),q(i,2),q(i,3),q(i,4), c1,c2,c3, v(i,1), v(i,2), v(i,3), v(i,4), m(1), m(2), m(3), m(4)} );
end
%%
figure(1)
plot(tt1,kinet{1})
xlabel('[s]')
ylabel('[J]')
title('en kinetyczna: cz這n 1, pryzmatyczny')

figure(2)
plot(tt1,kinet{2})
hold on
plot(tt1,kinet{3}, 'r')
plot(tt1,kinet{4},'g')
plot(tt1,kinet{5},'k')
xlabel('[s]')
ylabel('[J]')
title('en kinetyczna: cz這ny obrotowe')
legend('2','3','4','ca趾owita');


figure(3)
plot(tt1,pot{1})
xlabel('[s]')
ylabel('[J]')
title('en potencjalna: cz這n 1, pryzmatyczny')

figure(4)
plot(tt1,pot{2})
hold on
plot(tt1,pot{3}, 'r')
plot(tt1,pot{4},'g')
plot(tt1,pot{5},'k')
xlabel('[s]')
ylabel('[J]')
title('en potencjalna: cz這ny obrotowe')
legend('2','3','4','ca趾owita');
%% 
















