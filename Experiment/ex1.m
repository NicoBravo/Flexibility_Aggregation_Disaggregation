clear
clc
close all
yalmip('clear')

blues = randn(2,25);
greens = randn(2,25)+2;
% plot(greens(1,:),greens(2,:),'g*')
% hold on
% plot(blues(1,:),blues(2,:),'b*')
a = sdpvar(2,1);
b = sdpvar(1);
u = sdpvar(1,25);
v = sdpvar(1,25);
Constraints = [a'*greens+b >= 1-u, a'*blues+b <= -(1-v), u >= 0, v >= 0];
Objective = sum(u)+sum(v);
Constraints = [Constraints, -1 <= a <= 1];
options = sdpsettings('solver','mosek')
% options = sdpsettings(options, 'verbose',0)
options.verbose = 0;
options.showprogress = 1;
options.cachesolvers = 1;
sol=optimize(Constraints,Objective, options)
x = sdpvar(2,1);
P1 = [-5<=x<=5, value(a)'*x+value(b)>=0];
P2 = [-5<=x<=5, value(a)'*x+value(b)<=0];
% clf
% plot(P1);hold on
% plot(P2);
% plot(greens(1,:),greens(2,:),'g*')
% plot(blues(1,:),blues(2,:),'b*')