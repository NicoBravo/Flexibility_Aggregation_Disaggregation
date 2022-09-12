function ret=Initialization(lenchrom,bound,Containment_Type)
% 本函数将变量编码成染色体，用于随机初始化一个种群
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% ret        output: 染色体的编码值

global A_Um b_Um

flag=0;
while flag==0
    pick=rand(1,length(lenchrom)); 
    %生成一个随机的1*5的向量，每个字符0~1之间，是十进制
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %线性插值
        % 本质上是生成介于bound上下限之间的一个随机数
    flag=Test_Feasibility(lenchrom,bound,ret,Containment_Type);             %检验染色体的可行性，flag=1表示通过
end

% 理解ret:
% 比如b1=2,b2=5，那么b2-b1=3。然后对应的pick的值是0.6
% 那么ret=2+3*0.6=3.8,介于b1和b2之间
% 因为input的x是5维度，所以output是一个1*5的向量，每个值对应xi，介于规定的上下限之间
