clear
clc
close all
yalmip('clear')

a1=1; a2=0.5; a3=0.1;
x = -1:0.01:1;
y1 = -a1*x+1;
y2 = -a2*x+1;
y3 = -a3*x+1;

plot(x,y1,x,y2,x,y3)
legend('a1=1','a2=0.5','a3=0.1')