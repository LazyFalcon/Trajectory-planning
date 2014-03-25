function y=fun_path(X,T,V,A)
%% Description
% .........................................................................
% Autor:                    Dariusz Baran
% Date updating:            27.06.2010 r
% Department:               KRIM AGH
% .........................................................................
% This function determine multiplication factors for the graph trajectory.
% Syntax y=path(X,T,V,A)
% 
% Input data:
% X - vector of the successive of coordinates joints
% T - vector the time of displacement between the successive positions.
% Number of elements is one less than number of elements vector X
% V - velocities on a start and a finish trajectory [Vs Vf]
% A - acceleration on a start and a finish trajectory [As Av]
%
% Output data:
% y - vector includes equations describe displacement in a time successive
% part of trajectory.
%..........................................................................

if nargin < 4 || isempty(A), A=[0 0]; end
if nargin < 3 || isempty(V), X=[0 0]; end

%%
X2=size(X,2);
e=size(T,2);
eval('syms t')
% d=X2;
if X2==e
    disp('B³¹d, iloœæ podanych czasów miedzy kolejnymi punktami nie jest odpowiednia')
else
    a=sym(zeros(6*e,1));
k=1;
    for i=1:e
        for j=1:6
            a(k,1)=sym(strcat('a',num2str(i),num2str(j)));
        k=k+1;
        end
    end
%   n=1;
%% make the system of equations and save the multiplication constant in matrix rown and S   
    rown=zeros(6*e,6*e);
    S=zeros(6*e,1);
    j=1;
    for i=1:e
        rown(j,(i-1)*6+1)=1;
        S(j,1)=X(i);
        rown(j+1,(i-1)*6+1)=1;
        rown(j+1,(i-1)*6+2)=1;
        rown(j+1,(i-1)*6+3)=1;
        rown(j+1,(i-1)*6+4)=1;
        rown(j+1,(i-1)*6+5)=1;
        rown(j+1,(i-1)*6+6)=1;
        S(j+1,1)=X(i+1);
        j=j+2;
    end
    rown(j,2)=1/T(1);
    S(j,1)=V(1);
    rown(j+1,3)=2/T(1)^2;
    S(j+1,1)=A(1);
    j=j+2;
    rown(j,(e-1)*6+2)=1/T(e);
    rown(j,(e-1)*6+3)=2/T(e);
    rown(j,(e-1)*6+4)=3/T(e);
    rown(j,(e-1)*6+5)=4/T(e);
    rown(j,(e-1)*6+6)=5/T(e);
    S(j,1)=V(2);
    rown(j+1,(e-1)*6+3)=2/T(e)^2;
    rown(j+1,(e-1)*6+4)=6/T(e)^2;
    rown(j+1,(e-1)*6+5)=12/T(e)^2;
    rown(j+1,(e-1)*6+6)=20/T(e)^2;
    S(j+1,1)=A(2);
    j=j+2;
%%
    for i=2:e
        % first derivative
        rown(j,2+(i-2)*6)=1/T(i-1);
        rown(j,3+(i-2)*6)=2/T(i-1);
        rown(j,4+(i-2)*6)=3/T(i-1);
        rown(j,5+(i-2)*6)=4/T(i-1);
        rown(j,6+(i-2)*6)=5/T(i-1);
        rown(j,8+(i-2)*6)=-1/T(i);
        % second derivative
        rown(j+1,3+(i-2)*6)=2/T(i-1)^2;
        rown(j+1,4+(i-2)*6)=6/T(i-1)^2;
        rown(j+1,5+(i-2)*6)=12/T(i-1)^2;
        rown(j+1,6+(i-2)*6)=20/T(i-1)^2;
        rown(j+1,9+(i-2)*6)=-2/T(i)^2;
        % thrid derivative
        rown(j+2,4+(i-2)*6)=6/T(i-1)^3;
        rown(j+2,5+(i-2)*6)=24/T(i-1)^3;
        rown(j+2,6+(i-2)*6)=60/T(i-1)^3;
        rown(j+2,10+(i-2)*6)=-6/T(i)^3;
        % fourth derivative
        rown(j+3,5+(i-2)*6)=24/T(i-1)^4;
        rown(j+3,6+(i-2)*6)=120/T(i-1)^4;
        rown(j+3,11+(i-2)*6)=-24/T(i)^4;
        j=j+4;
    end
% S
% rown
% rownania=rown*a-S

% divide matrix rown of S
   rozw=vpa(rown\S);

%% make the function
y=sym(zeros(1,e));
   a=rozw;   
    for i=1:e
        y(i)=a((i-1)*6+1,1)+(a((i-1)*6+2,1))*t+(a((i-1)*6+3,1))*t^2+(a((i-1)*6+4,1))*t^3+(a((i-1)*6+5,1))*t^4+(a((i-1)*6+6,1))*t^5;
    end

end

end