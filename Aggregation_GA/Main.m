%% 清空环境
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
Bound_a = [amin amax]; % a的范围
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
% x0=0;  % 先不考虑Fx0的影响
% umin=zeros(h,1);
% umax=2*ones(h,1);
% xmin=zeros(h,1);  
% xmax=4*ones(h,1); 
% xmin=[];  xmax=[];
% a=1;
% [A_agg,b_agg]=Building_Contraint(a,umin,umax,xmin,xmax,x0);
% len_colume=size(A_agg,1);

%% 检测Uagg是否在Um中
% [A_agg,b_agg]=Building_Matrix(x);
% flag=If_Agg_in_Minkowski(A_agg,b_agg);


%% 遗传算法参数
maxgen=5;                         %进化代数5
sizepop=6;                       %种群规模6
pcross=[0.6];                      %交叉概率
pmutation=[0.1];                  %变异概率
lenchrom=[1 repmat(1,1,4*h)];        %变量字串长度  a 和 b=4*h
Bound=[Bound_a;   
       Bound_b1;  % umin的范围
       Bound_b2;  % umax的范围
       Bound_b3;  % xmin的范围
       Bound_b4;  % xmax的范围
       ]; 


%% 个体初始化
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %种群结构体
    % struct格式，两部分分别叫做fitness和chrom
    % fitness记录个体的适应度，1*sizepop个
    % chrom 是sizepop*5的矩阵，代表当前的所有个体的分布
    % chrom每一行记录每个个体的值，因为x是5维，所以行是1*5，对应每个xi
    % chrom共sizepop行
    % fitness的每一行与chrom的每一列都对应
avgfitness=[];                                               %种群平均适应度
bestfitness=[];                                              %种群最佳适应度
bestchrom=[];                                                %适应度最好染色体
% 初始化种群
for i=1:sizepop
    individuals.chrom(i,:)=Initialization(lenchrom,Bound,Containment_Type);       %随机产生个体
        % Code就是初始化函数
        % 执行一次code生成一个个体的初始化的值，1*5的向量，xi介于bound规定的上下限中
        % 依然还是十进制
    x=individuals.chrom(i,:);
    [A_agg,b_agg]=Building_Matrix(x);
    individuals.fitness(i)=Fitness(Fitness_Type,A_agg,b_agg);                     %个体适应度
end

%找最好的染色体
[bestfitness bestindex]=max(individuals.fitness); %max函数可以同时给出最小值和index
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace=[];

%% 进化开始
for i=1:maxgen
    
    % 选择操作
    individuals=Select(individuals,sizepop);
    avgfitness=sum(individuals.fitness)/sizepop;
    % 交叉操作
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,Bound,Containment_Type);
    % 变异操作
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i maxgen],Bound,Containment_Type);
    % [i maxgen]就是函数内部的pop参数
    
%     if mod(i,10)==0
%         individuals.chrom=nonlinear(individuals.chrom,sizepop);
%         % 使用fmincon函数直接求解
%         % 这也是为什么书里说采用非线性规划算法进行局部搜索
%     end
    
    % 计算适应度
    for j=1:sizepop
        x=individuals.chrom(j,:);
        [A_agg,b_agg]=Building_Matrix(x);
        individuals.fitness(j)=Fitness(Fitness_Type,A_agg,b_agg);
    end
    
    % 保底机制整体思路：子代最差的个体被父代或者子代最优的个体所替代
    
    %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=max(individuals.fitness);
    [worestfitness,worestindex]=min(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness<newbestfitness 
        % bestfitness是父代的最优值
        % bestfitness<newbestfitness 代表子代的最优的结果值更小，也就是适应度更高
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度
end
%进化结束

%% 结果显示
figure
[r c]=size(trace);
plot([1:r]',trace(:,1),'r-',[1:r]',trace(:,2),'b--');
title(['Evolution curve  ' 'Final generation＝' num2str(maxgen)],'fontsize',12);
xlabel('Evolution generation','fontsize',12);ylabel('Fitness','fontsize',12);
legend('Average','Optimal','fontsize',12);
% ylim([0 1])
disp('Function                   Variable');
% 窗口显示
disp([bestfitness x]);
grid on

toc
