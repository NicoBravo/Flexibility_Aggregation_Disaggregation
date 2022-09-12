clc
clear
close all

h=2;

%% for Um
x0_Um=0;
umin_Um=-100*ones(h,1);
umax_Um=100*ones(h,1);
xmin_Um=[];
xmax_Um=[];
a_Um=1;
[A_Um,b_Um]=Building_Contraint(a_Um,umin_Um,umax_Um,xmin_Um,xmax_Um,x0_Um);
len_row=size(A_Um,1);

Um=Polyhedron(A_Um,b_Um); 


%% for Uagg

x0=0;
umin=zeros(h,1);
umax=2*ones(h,1);
xmin=zeros(h,1);  
xmax=4*ones(h,1); 
xmin=[];  xmax=[];
a=1;
[A_agg,b_agg]=Building_Contraint(a,umin,umax,xmin,xmax,x0);
len_colume=size(A_agg,1);
Uagg=Polyhedron(A_agg,b_agg);  

flag = (Uagg <= Um)



%% 判断Uagg是否∈Um
% cvx_begin
%     variables L(len_row,len_colume) 
%     minimize( norm(L,1) )
%     % minimize could be saved, just to test existance
%     subject to
%         L >= 0;
%         L*A_agg == A_Um;
%         L*b_agg <= b_Um;
% cvx_end
% 
% if strcmp(cvx_status,'Solved')
%     flag = true;
% elseif strcmp(cvx_status,'Infeasible')
%     flag = false;
% end






