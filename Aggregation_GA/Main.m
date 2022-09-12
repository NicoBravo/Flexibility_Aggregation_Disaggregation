%% ��ջ���
clc
clear
close all
warning off

tic

%% Initial Parameters
% horizon
h=2;

% choose tool
Fitness_Type='MPT';
% Fitness_Type='VolEsti';
% Fitness_Type='Ben';

% Containment_Type='CVX'; 
% Containment_Type='Yalmip';
Containment_Type='MPT';

% aggregation parameter
x0 = 0.5;
amin = 0.5; amax = 2;
Bound_a = [amin amax]; % a�ķ�Χ
Bound_Umin=[0 0]; Bound_Umin_horizon = repmat(Bound_Umin,h,1);
Bound_Umax=[0 2]; Bound_Umax_horizon = repmat(Bound_Umax,h,1);
Bound_Xmin=[0 2]; Bound_Xmin_horizon = repmat(Bound_Xmin,h,1);
Bound_Xmax=[0 4]; Bound_Xmax_horizon = repmat(Bound_Xmax,h,1);

[Bound_b1,Bound_b2,Bound_b3,Bound_b4]=Bound_FromModel_to_GA ...
(x0, amin, amax, Bound_Umin_horizon,Bound_Umax_horizon,Bound_Xmin_horizon,Bound_Xmax_horizon);

 
   
%% give Um information
% for Um
x0_Um=0;
umin_Um=-1*ones(h,1);
umax_Um=1*ones(h,1);
xmin_Um=[];
xmax_Um=[];
a_Um=1;
global A_Um b_Um
[A_Um,b_Um]=Building_Contraint(a_Um,umin_Um,umax_Um,xmin_Um,xmax_Um,x0_Um);




% for Uagg
% x0=0;  % �Ȳ�����Fx0��Ӱ��
% umin=zeros(h,1);
% umax=2*ones(h,1);
% xmin=zeros(h,1);  
% xmax=4*ones(h,1); 
% xmin=[];  xmax=[];
% a=1;
% [A_agg,b_agg]=Building_Contraint(a,umin,umax,xmin,xmax,x0);
% len_colume=size(A_agg,1);

%% ���Uagg�Ƿ���Um��
% [A_agg,b_agg]=Building_Matrix(x);
% flag=If_Agg_in_Minkowski(A_agg,b_agg);


%% �Ŵ��㷨����
maxgen=5;                         %��������5
sizepop=6;                       %��Ⱥ��ģ6
pcross=[0.6];                      %�������
pmutation=[0.1];                  %�������
lenchrom=[1 repmat(1,1,4*h)];        %�����ִ�����  a �� b=4*h
Bound=[Bound_a;   
       Bound_b1;  % umin�ķ�Χ
       Bound_b2;  % umax�ķ�Χ
       Bound_b3;  % xmin�ķ�Χ
       Bound_b4;  % xmax�ķ�Χ
       ]; 


%% �����ʼ��
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %��Ⱥ�ṹ��
    % struct��ʽ�������ֱַ����fitness��chrom
    % fitness��¼�������Ӧ�ȣ�1*sizepop��
    % chrom ��sizepop*5�ľ��󣬴���ǰ�����и���ķֲ�
    % chromÿһ�м�¼ÿ�������ֵ����Ϊx��5ά����������1*5����Ӧÿ��xi
    % chrom��sizepop��
    % fitness��ÿһ����chrom��ÿһ�ж���Ӧ
avgfitness=[];                                               %��Ⱥƽ����Ӧ��
bestfitness=[];                                              %��Ⱥ�����Ӧ��
bestchrom=[];                                                %��Ӧ�����Ⱦɫ��
% ��ʼ����Ⱥ
for i=1:sizepop
    individuals.chrom(i,:)=Initialization(lenchrom,Bound,Containment_Type);       %�����������
        % Code���ǳ�ʼ������
        % ִ��һ��code����һ������ĳ�ʼ����ֵ��1*5��������xi����bound�涨����������
        % ��Ȼ����ʮ����
    x=individuals.chrom(i,:);
    [A_agg,b_agg]=Building_Matrix(x);
    individuals.fitness(i)=Fitness(Fitness_Type,A_agg,b_agg);                     %������Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=max(individuals.fitness); %max��������ͬʱ������Сֵ��index
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; %Ⱦɫ���ƽ����Ӧ��
% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace=[];

%% ������ʼ
for i=1:maxgen
    
    % ѡ�����
    individuals=Select(individuals,sizepop);
    avgfitness=sum(individuals.fitness)/sizepop;
    % �������
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,Bound,Containment_Type);
    % �������
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i maxgen],Bound,Containment_Type);
    % [i maxgen]���Ǻ����ڲ���pop����
    
%     if mod(i,10)==0
%         individuals.chrom=nonlinear(individuals.chrom,sizepop);
%         % ʹ��fmincon����ֱ�����
%         % ��Ҳ��Ϊʲô����˵���÷����Թ滮�㷨���оֲ�����
%     end
    
    % ������Ӧ��
    for j=1:sizepop
        x=individuals.chrom(j,:);
        [A_agg,b_agg]=Building_Matrix(x);
        individuals.fitness(j)=Fitness(Fitness_Type,A_agg,b_agg);
    end
    
    % ���׻�������˼·���Ӵ����ĸ��屻���������Ӵ����ŵĸ��������
    
    %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=max(individuals.fitness);
    [worestfitness,worestindex]=min(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness<newbestfitness 
        % bestfitness�Ǹ���������ֵ
        % bestfitness<newbestfitness �����Ӵ������ŵĽ��ֵ��С��Ҳ������Ӧ�ȸ���
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
end
%��������

%% �����ʾ
figure
[r c]=size(trace);
plot([1:r]',trace(:,1),'r-',[1:r]',trace(:,2),'b--');
title(['Evolution curve  ' 'Final generation��' num2str(maxgen)],'fontsize',12);
xlabel('Evolution generation','fontsize',12);ylabel('Fitness','fontsize',12);
legend('Average','Optimal','fontsize',12);
% ylim([0 1])
disp('Function                   Variable');
% ������ʾ
disp([bestfitness x]);
grid on

toc
