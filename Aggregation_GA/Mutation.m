function ret=Mutation(pmutation,lenchrom,chrom,sizepop,pop,bound,Containment_Type)
% ��������ɱ������
% pcorss                input  : �������
% lenchrom              input  : Ⱦɫ�峤��
% chrom                 input  : Ⱦɫ��Ⱥ
% sizepop               input  : ��Ⱥ��ģ
% pop                   input  : ��ǰ��Ⱥ�Ľ������������Ľ���������Ϣ
    % �������ľ���[i maxgen]  
% ret                   output : ������Ⱦɫ��

for i=1:sizepop  
    % ÿ�����壬x���ѡ��x1-x5�е�һ��������б���
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);  % ѡ��1-sizepop���ĸ�������б���
    % ������ʾ�������ѭ���Ƿ���б���
    pick=rand;
    if pick>pmutation
        continue;
    end
    flag=0;
    while flag==0
        % ����λ��
        pick=rand;
        while pick==0
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));  %���ѡ�����x1-x5�ĸ�������б���
        v=chrom(i,pos); %����i�ĵ�pos��������б���
        v1=v-bound(pos,1); % ���й�ʽ(2-6)��-(amin-aij)
        v2=bound(pos,2)-v; % ���й�ʽ(2-6)��-(aij-amax)
        pick=rand; %���쿪ʼ
        if pick>0.5
            delta=v2*(1-pick^((1-pop(1)/pop(2))^2));
            % pop(1)=i����ʽ�еĵ�ǰ��������g,  pop(2)=maxgen�����е�����������Gmax
            % 1-pick^(   ( 1-pop(1)/pop(2) )^2   )
            % pick^((1-pop(1)/pop(2))^2)���ǹ�ʽ�е�f(g)=r2(1-g/Gmax)^2
            % ����delta=v2*(  1-f(g) ) ???���û������Ϊ��ʽ����������
            chrom(i,pos)=v+delta;
        else
            delta=v1*(1-pick^((1-pop(1)/pop(2))^2));
            chrom(i,pos)=v-delta;
        end   %�������
        flag=Test_Feasibility(lenchrom,bound,chrom(i,:),Containment_Type);     %����Ⱦɫ��Ŀ�����
    end
end
ret=chrom;