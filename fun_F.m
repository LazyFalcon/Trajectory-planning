function F=fun_F(J,ms,v,a,g,gp,zmie,wsp)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2009 r
% Department:               KRIM AGH
% .........................................................................
% Function to determine forces/moments of force in each joint. 
% Syntax F=fun_F(J,ms,v,a,g,gp,zmie,wsp)
% 
% Input data:
% J - matrix includes tensor intertial 
% ms - mass successive elements of manipulator
% v - vector of instantaneous velocities each of joints
% a - vector of instantaneous accelerations each of joints
% g - defines where is direction of gravitational force in basic coordinates
% system
% gp - matrix includes in rows parameters relate to the sequence
% transformations
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems:
% 1 - variable parameter
% 0 - constant parameter
% It can be only one 1 in row.
% wsp - matrix include position of centre of gravity each
% elements of manipulator relative local coordinates system.
%
% Output data:
% F - vector containing functions or values forces/moments of force in
% successive joints. 
% .........................................................................

%%
n=length(v);
wb=waitbar(0,'calculate forces/moments of forces');
F=sym(zeros(1,n));
for p=1:n
    L1=0;
    L2=0;
    L3=0;
    for i=p:n
        for k=1:i
            U1=fun_dTe(gp,zmie,i);
            L11=trace(U1{k}*J{i}*U1{p}')*a(k);
            L1=L11+L1;
        end
    end
    for i=p:n
        for k=1:i
            for m=1:i
                U1=fun_dTe(gp,zmie,i);
                U2=fun_ddTe(gp,zmie,i);
                L22=trace(U2{k,m}*J{i}*U1{p}')*v(k)*v(m);
                L2=L22+L2;
            end
        end
    end
    for i=p:n
        U3=fun_dTe(gp,zmie,i);
        L33=ms(i)*g*U3{p}*wsp(i,:)';
        L3=L3+L33;
    end
    F(p)=L1+L2-L3;
    waitbar(p/n,wb);
    
end
close(wb)
end