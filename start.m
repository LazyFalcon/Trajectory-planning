% przyklady manipulatorów
disp('Prosze podac typ manipulatora, który pos³u¿y do eksperymentów')
disp('1. Manipulator o strukturze Cylindryczne (RPP) ')
disp('2. Manipulator o strukturze Scara ( RRPR)')
disp('3. Manipulator o strukturze PPPRR')
disp('4. Manipulator o strukturze Kartezjanskiej ( PPP )')
disp('5. Manipulator o strukturze Sferycznej ( RRP )')
disp('6. Manipulator z ostatim przejsciem bez zmiennej')
disp('7. Przyk³ad do trajektorii 1')
disp('8. Przyk³ad do trajektorii 2')
disp('9. Labolatorium temat nr 11')
disp('10. Manipulator o strukturze Scara 2 ( RRP)')
disp('11. Manipulator o strukturze antropomorficznej ( RRR)')
disp('12. Manipulator o strukturze Cylindryczne (RPP) bez sym przy k¹tach, przyklad do predkosci')
r=input(':');
if r==1
% Manipulator o strukturze Cylindryczny
    syms th1 d2 d3 vz1 vz2 vz3 az1 az2 az3
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3]
    az=[az1 az2 az3]
    gp=[th1,0,0,0;0,d2,0,sym(-pi/2);0,d3,0,sym(-pi/2)]
    zmie=[1,0,0,0;0,1,0,0;0,1,0,0]
elseif r==2
% Manipulator o strukturze Scara 
    syms th1 a1 th2 a2 d3 th4 vz1 vz2 vz3 vz4 az1 az2 az3 az4 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3 vz4]
    az=[az1 az2 az3 az4]
    gp=[th1 0 a1 0;th2 0 a2 sym(pi);0 d3 0 0;th4 0 0 0]
    zmie=[1 0 0 0;1 0 0 0;0 1 0 0;1 0 0 0]
elseif r==3
% Manipulator o strukturze PPPRR
    syms a1 d2 d3 th4 th5 d5 vz1 vz2 vz3 vz4 vz5 az1 az2 az3 az4 az5 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3 vz4 vz5]
    az=[az1 az2 az3 az4 az5]
    gp=[0 0 a1 sym(pi/2); 0 d2 0 sym(pi/2);0 d3 0 -sym(pi/2);th4 0 0 sym(pi/2);th5 d5 0 0]
    zmie=[0 0 1 0;0 1 0 0;0 1 0 0;1 0 0 0;1 0 0 0]
elseif r==4
% Manipulator o strukturze Kartezjanskiej
    syms d1 a2 d3 vz1 vz2 vz3 az1 az2 az3 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3]
    az=[az1 az2 az3]
    gp=[0,d1,0,0;0,0,a2,sym(pi/2);0,d3,0,0]
    zmie=[0,1,0,0;0,0,1,0;0,1,0,0]
elseif r==5
% Manipulator o strukturze Sferycznej ( RRP )
    syms th1 a1 th2 a2 vz1 vz2 vz3 az1 az2 az3 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3]
    az=[az1 az2 az3]
    gp=[th1 0 a1 0;th2 0 a2 sym(pi);0 d3 0 0]
    zmie=[1 0 0 0;1 0 0 0;0 1 0 0]
elseif r==6
% uklad z ostatnim przejsciem bez zmiennej
    syms th1 d1 th2 d3 d4 vz1 vz2 vz3 az1 az2 az3 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3]
    az=[az1 az2 az3]
    gp=[th1 d1 0 -sym(pi/2);th2 0 0 sym(pi/2);0 d3 0 0;0 d4 0 0]
    zmie=[1 0 0 0;1 0 0 0;0 1 0 0;0 0 0 0]
elseif r==7
% przyklad do trajektorii
    X=[0,0.3,0.6,0.9]
    T=[1,1,1]
    V=[0,0]
    A=[0,0]
elseif r==8
% przyklad do trajektorii
    X=[-1,0.3,1.7,2,1.5]
    T=[1,1.25,1,1.5]
    V=[0,0]
    A=[0,0]
elseif r==9
% Manipulator
    syms th1 a1 th2 d3 th4 d5 real
    p=[0;0;0;1]
    gp=[th1 0 a1 sym(-pi/2);th2 0 0 sym(-pi/2);0 d3 0 sym(pi/2);th4 0 0 sym(-pi/2);sym(pi/2) d5 0 0]
    zmie=[1 0 0 0;1 0 0 0;0 1 0 0;1 0 0 0;0 0 0 0]
elseif r==10
% Manipulator o strukturze Scara 
    syms th1 a1 th2 a2 d3 th4 vz1 vz2 vz3 vz4 az1 az2 az3 az4 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3 vz4]
    az=[az1 az2 az3 az4]
    gp=[th1 0 a1 0;th2 0 a2 sym(pi);0 d3 0 0]
    zmie=[1 0 0 0;1 0 0 0;0 1 0 0]
elseif r==11
% Manipulator o strukturze antropomorficzny
    syms th1 th2 th3 d1 a2 d4 vz1 vz2 vz3 az1 az2 az3 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3]
    az=[az1 az2 az3]
    gp=[th1,d1,0,sym(-pi/2);th2,0,a2,0;th3,0,0,sym(pi/2);0,d4,0,0]
    zmie=[1,0,0,0;0,1,0,0;0,1,0,0;0,0,0,0]
elseif r==12
% Manipulator o strukturze Cylindryczny, przyklad do predkosci
    syms th1 d2 d3 vz1 vz2 vz3 az1 az2 az3 al1 al2 real
    p=[0;0;0;1]
    vz=[vz1 vz2 vz3]
    az=[az1 az2 az3]
    gp=[th1,0,0,0;0,d2,0,al1;0,d3,0,-al2]
    zmie=[1,0,0,0;0,1,0,0;0,1,0,0]
end
    
    
    