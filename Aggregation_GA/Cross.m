function ret=Cross(pcross,lenchrom,chrom,sizepop,bound,Containment_Type)
%本函数完成交叉操作
% pcorss                input  : 交叉概率
% lenchrom              input  : 染色体的长度
% chrom                 input  : 染色体群
% sizepop               input  : 种群规模
% ret                   output : 交叉后的染色体

for i=1:sizepop 
    
    % 随机选择两个染色体进行交叉
    pick=rand(1,2); % 这个pick是为了找两个随机的交叉的个体
    while prod(pick)==0 % 避免rand=0的极端情况
        pick=rand(1,2);
    end
    index=ceil(pick.*sizepop); % Chrom这个群体有多个个体，每个个体有x1-x5这五个基因。所以index是哪两个个体进行交叉
        % ceil是向着+∞找到最近的整数
        % 所以最终的结果是为了找到随机交叉的两个index
        % ？？？问题：可能存在index两个数完全相等的可能性
        % 应该检测是否相等
    % 交叉概率决定是否进行交叉
    pick=rand; %都是pick，性质不同。这个是为了生成和pc对比的概率
    while pick==0
        pick=rand;
    end
    if pick>pcross
        continue;
    end
    flag=0;
    while flag==0
        % 随机选择交叉位置
        pick=rand;
        while pick==0
            pick=rand;
        end
        pos=ceil(pick.*sum(lenchrom)); %随机选择进行x1-x5这五个基因哪个进行交叉
        pick=rand; %交叉开始
        v1=chrom(index(1),pos);
        v2=chrom(index(2),pos);
        chrom(index(1),pos)=pick*v2+(1-pick)*v1;
        chrom(index(2),pos)=pick*v1+(1-pick)*v2; %交叉结束
            % 注意，这个程序，自始至终没有进行二进制的编码
            % 所以这里的交叉，其实是pos这个xi，index(1)和index(2)分别贡献一个pick的比例，然后交换
        flag1=Test_Feasibility(lenchrom,bound,chrom(index(1),:),Containment_Type);  %检验染色体1的可行性
        flag2=Test_Feasibility(lenchrom,bound,chrom(index(2),:),Containment_Type);  %检验染色体2的可行性
        if   flag1*flag2==0
            flag=0;
        else flag=1;
        end    %如果两个染色体不是都可行，则重新交叉
    end
end
ret=chrom;  
