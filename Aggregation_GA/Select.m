function ret=Select(individuals,sizepop)
% ��������ÿһ����Ⱥ�е�Ⱦɫ�����ѡ���Խ��к���Ľ���ͱ���
% individuals input  : ��Ⱥ��Ϣ
% sizepop     input  : ��Ⱥ��ģ
% opts        input  : ѡ�񷽷���ѡ��
% ret         output : ����ѡ������Ⱥ

% �������̶ĵĲ���

sumfitness=sum(individuals.fitness);
sumf=individuals.fitness./sumfitness; % ���̶Ĳ��õĸ��ʣ��Ǹ��Եĸ���
index=[];
for i=1:sizepop   %תsizepop������
    pick=rand; % ����һ�������ֵ
    while pick==0 % ����pick=0�ļ������
        pick=rand;
    end
    for j=1:sizepop
        pick=pick-sumf(j);
        if pick<0
            index=[index j];
            break;  %Ѱ����������䣬�˴�ת����ѡ����Ⱦɫ��i��ע�⣺��תsizepop�����̵Ĺ����У��п��ܻ��ظ�ѡ��ĳЩȾɫ��
        end
    end
end
individuals.chrom=individuals.chrom(index,:);
    % index��һ�����������������һ��������˸���
individuals.fitness=individuals.fitness(index);
ret=individuals;