function ret=Cross(pcross,lenchrom,chrom,sizepop,bound,Containment_Type)
%��������ɽ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ��ĳ���
% chrom                 input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% ret                   output : ������Ⱦɫ��

for i=1:sizepop 
    
    % ���ѡ������Ⱦɫ����н���
    pick=rand(1,2); % ���pick��Ϊ������������Ľ���ĸ���
    while prod(pick)==0 % ����rand=0�ļ������
        pick=rand(1,2);
    end
    index=ceil(pick.*sizepop); % Chrom���Ⱥ���ж�����壬ÿ��������x1-x5�������������index��������������н���
        % ceil������+���ҵ����������
        % �������յĽ����Ϊ���ҵ�������������index
        % ���������⣺���ܴ���index��������ȫ��ȵĿ�����
        % Ӧ�ü���Ƿ����
    % ������ʾ����Ƿ���н���
    pick=rand; %����pick�����ʲ�ͬ�������Ϊ�����ɺ�pc�Աȵĸ���
    while pick==0
        pick=rand;
    end
    if pick>pcross
        continue;
    end
    flag=0;
    while flag==0
        % ���ѡ�񽻲�λ��
        pick=rand;
        while pick==0
            pick=rand;
        end
        pos=ceil(pick.*sum(lenchrom)); %���ѡ�����x1-x5����������ĸ����н���
        pick=rand; %���濪ʼ
        v1=chrom(index(1),pos);
        v2=chrom(index(2),pos);
        chrom(index(1),pos)=pick*v2+(1-pick)*v1;
        chrom(index(2),pos)=pick*v1+(1-pick)*v2; %�������
            % ע�⣬���������ʼ����û�н��ж����Ƶı���
            % ��������Ľ��棬��ʵ��pos���xi��index(1)��index(2)�ֱ���һ��pick�ı�����Ȼ�󽻻�
        flag1=Test_Feasibility(lenchrom,bound,chrom(index(1),:),Containment_Type);  %����Ⱦɫ��1�Ŀ�����
        flag2=Test_Feasibility(lenchrom,bound,chrom(index(2),:),Containment_Type);  %����Ⱦɫ��2�Ŀ�����
        if   flag1*flag2==0
            flag=0;
        else flag=1;
        end    %�������Ⱦɫ�岻�Ƕ����У������½���
    end
end
ret=chrom;  
