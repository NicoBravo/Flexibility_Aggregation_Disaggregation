function ret=Select(individuals,sizepop)
% 本函数对每一代种群中的染色体进行选择，以进行后面的交叉和变异
% individuals input  : 种群信息
% sizepop     input  : 种群规模
% opts        input  : 选择方法的选择
% ret         output : 经过选择后的种群

% 基于轮盘赌的策略

sumfitness=sum(individuals.fitness);
sumf=individuals.fitness./sumfitness; % 轮盘赌采用的概率，是各自的概率
index=[];
for i=1:sizepop   %转sizepop次轮盘
    pick=rand; % 生成一个随机的值
    while pick==0 % 避免pick=0的极端情况
        pick=rand;
    end
    for j=1:sizepop
        pick=pick-sumf(j);
        if pick<0
            index=[index j];
            break;  %寻找落入的区间，此次转轮盘选中了染色体i，注意：在转sizepop次轮盘的过程中，有可能会重复选择某些染色体
        end
    end
end
individuals.chrom=individuals.chrom(index,:);
    % index是一个行向量，这个就是一步就完成了复制
individuals.fitness=individuals.fitness(index);
ret=individuals;