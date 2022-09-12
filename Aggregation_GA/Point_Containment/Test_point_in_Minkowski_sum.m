% test a point could be seperated and if in Minkowski sum of m sets

clear
clc
close all
yalmip('clear')

% set 1
A1=[1 0;-1 0;0 1;0 -1];  b1=[1;1;1;1];
P1=Polyhedron(A1,b1);
% set 2
A2=[-1 0;0 -1;1 1];  b2=[0;0;2];
P2=Polyhedron(A2,b2);
figure(1)
plot(P1,'color','lightgreen', P2,'color','yellow')
title('S1→green  S2→yellow');

% Minkowski sum
Pm=P1+P2;
figure(2)
plot(Pm,'color','lightblue')
title('Sm→blue');
P=[P1;P2];

% sizes
m=2; % set number
n=2; % dimension of u

% define the point
% v=[2;2];
% v=[2.5;1];
v=[3;3];

% optimization
D=sdpvar(n,m,'full');
C1=[ D(:)>=0 ]; % D elements must be non-negative
C2=[ sum(D,2)==1  ]; % D line sum == 1
C3=[];
for j = 1:m
    subpoint=[];
    for i = 1:n
        subpoint=[subpoint; D(i,j)*v(i)];
    end
    Fin=ismember(subpoint,P(j));
    C3=[C3, Fin];
end
C=[C1,C2,C3];
sol = optimize(C,D);
value(D)
