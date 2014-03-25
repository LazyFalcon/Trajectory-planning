function M=zam(zmie,M,sy)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            11.01.2008 r
% Department:               KRIM AGH
% .........................................................................
% This function are changing in matrix M cos() or sin() with symbol to the
% one symbol:
% cos(qx) to Cx 
% cos(qx+qy) to Cxy
% sin(qx) to Sx
% sin(qx+qy) to Sxy
% cos(qx-qy) to Cx_y
% sin(qx-qy) to Sx_y
% Syntax M=zam(zmie,M)
%
% Input data:
% M - matrix includes expression to change
% zmie - (0,1)-matrix size nx4. Rows relate to the sequence transformations
% of coordinate systems: 
% 1 - variable parameter 
% 0 - constant parameter
% It can be only one 1 in row. 
% 
% Output data:
% M - matrix after change expression.
% .........................................................................

%%
if nargin < 3 || isempty(sy), sy='q'; end
    
M=simplify(M);
x=size(zmie,1); 

%% Create the symbolic q
q=sym(zeros(1,x));
for i=1:x
    q(i)=sym(strcat(sy,num2str(i)));
end

%% Create the symbolic Cxy
c1=sym(zeros(x));
for n=1:x
    for m=1:x
        if n==m
            c1(n,m)=sym(strcat('C',num2str(n)));
        elseif n<m
            c1(n,m)=sym(strcat('C',num2str(n),num2str(m)));
        else
            c1(n,m)=0;
        end
    end
end

%% Create the symbolic Sxy
s1=sym(zeros(x));
for n=1:x
    for m=1:x
        if n==m
            s1(n,m)=sym(strcat('S',num2str(n)));
        elseif n<m
            s1(n,m)=sym(strcat('S',num2str(n),num2str(m)));
        else
            s1(n,m)=0;
        end
    end
end

%% Create the symbolic Cx_y
c2=sym(zeros(x));
for n=1:x
    for m=1:x
        if n ~= m 
            c2(n,m)=sym(strcat('C',num2str(n),'_',num2str(m)));
        end
    end
end

%% Create the symbolic Sx_y
s2=sym(zeros(x));
for n=1:x
    for m=1:x
        if n ~= m 
            s2(n,m)=sym(strcat('S',num2str(n),'_',num2str(m))); 
        end
    end
end

%% Change cos(th(i)) to Ci and sin(th(i)) to Si
for i=1:x
    M=subs(M,cos(q(i)),c1(i,i));     
    M=subs(M,sin(q(i)),s1(i,i));
end

%% Change cos(q(i)+q(n)) to Cin and sin(q(i)+q(n)) Sin
for i=1:x
    for n=1:x
        if i<n
            M=subs(M,cos(q(i)+q(n)),c1(i,n));
            M=subs(M,sin(q(i)+q(n)),s1(i,n));
        end
    end
end

%% Change cos(th(i)-th(n)) to Ci_n and sin(th(i)-th(n)) Si_n
for i=1:x
    for n=1:x
        if i~=n
            M=subs(M,cos(q(i)-q(n)),c2(i,n));
            M=subs(M,sin(q(i)-q(n)),s2(i,n));
        end
    end
end 

end