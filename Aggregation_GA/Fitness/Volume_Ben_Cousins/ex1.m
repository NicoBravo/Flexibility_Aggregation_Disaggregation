clear
clc
close all

% origin is not contained
% result is correct if not preprocess
A_1 = [eye(2); -eye(2)];
b_1 = [4; 6; -1; -1];
A_eq_1 = [];
b_eq_1=[];
p_1_in= [3;3];  % 提供一个内点
P_1.A=A_1;
P_1.b=b_1;
P_1.A_eq=A_eq_1;
P_1.b_eq=b_eq_1;
P_1.p=p_1_in;
[vol_1,T,steps] = Volume(P_1,[],0.1)
Ao=P_1.A; 
bo=P_1.b;
Po=Polyhedron(Ao,bo);
figure
Po.plot

% result is not correct if with preprocess
P_1_process = preprocess(P_1);
vol_1_process = Volume(P_1_process,[],0.1)
% [vo1,T,steps] = Volume(P_1_process)


% origin is contained, result is correct
% A_2 = [eye(2); -eye(2)];
% b_2 = [5; 6; -1; -1];
% A_eq_2 = [];
% b_eq_2=[];
% p_2_in= [2;2];
% P_2.A=A_2;
% P_2.b=b_2;
% P_2.A_eq=A_eq_2;
% P_2.b_eq=b_eq_2;
% P_2.p=p_2_in;
% P_2_process = preprocess(P_2);
% vol_2 = Volume(P_2_process)
% 
% Ao=P_2.A; 
% bo=P_2.b;
% Po=Polyhedron(Ao,bo);
% figure
% Po.plot
% 
% 
% Ap=P_2_process.A; 
% bp=P_2_process.b;
% Pp=Polyhedron(Ap,bp);
% figure
% Pp.plot







