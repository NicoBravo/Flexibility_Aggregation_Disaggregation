function ret=Mutation(pmutation,lenchrom,chrom,sizepop,pop,bound,Containment_Type)
% 本函数完成变异操作
% pcorss                input  : 变异概率
% lenchrom              input  : 染色体长度
% chrom                 input  : 染色体群
% sizepop               input  : 种群规模
% pop                   input  : 当前种群的进化代数和最大的进化代数信息
    % 传过来的就是[i maxgen]  
% ret                   output : 变异后的染色体

for i=1:sizepop  
    % 每个个体，x随机选择x1-x5中的一个基因进行变异
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);  % 选择1-sizepop的哪个个体进行变异
    % 变异概率决定该轮循环是否进行变异
    pick=rand;
    if pick>pmutation
        continue;
    end
    flag=0;
    while flag==0
        % 变异位置
        pick=rand;
        while pick==0
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));  %随机选择个体x1-x5哪个基因进行变异
        v=chrom(i,pos); %个体i的第pos个基因进行变异
        v1=v-bound(pos,1); % 书中公式(2-6)的-(amin-aij)
        v2=bound(pos,2)-v; % 书中公式(2-6)的-(aij-amax)
        pick=rand; %变异开始
        if pick>0.5
            delta=v2*(1-pick^((1-pop(1)/pop(2))^2));
            % pop(1)=i，公式中的当前迭代次数g,  pop(2)=maxgen，书中的最大进化次数Gmax
            % 1-pick^(   ( 1-pop(1)/pop(2) )^2   )
            % pick^((1-pop(1)/pop(2))^2)就是公式中的f(g)=r2(1-g/Gmax)^2
            % 所以delta=v2*(  1-f(g) ) ???这个没懂，因为公式不是这样的
            chrom(i,pos)=v+delta;
        else
            delta=v1*(1-pick^((1-pop(1)/pop(2))^2));
            chrom(i,pos)=v-delta;
        end   %变异结束
        flag=Test_Feasibility(lenchrom,bound,chrom(i,:),Containment_Type);     %检验染色体的可行性
    end
end
ret=chrom;