function ret=Initialization(lenchrom,bound,Containment_Type)
% �����������������Ⱦɫ�壬���������ʼ��һ����Ⱥ
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% ret        output: Ⱦɫ��ı���ֵ

global A_Um b_Um

flag=0;
while flag==0
    pick=rand(1,length(lenchrom)); 
    %����һ�������1*5��������ÿ���ַ�0~1֮�䣬��ʮ����
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %���Բ�ֵ
        % �����������ɽ���bound������֮���һ�������
    flag=Test_Feasibility(lenchrom,bound,ret,Containment_Type);             %����Ⱦɫ��Ŀ����ԣ�flag=1��ʾͨ��
end

% ���ret:
% ����b1=2,b2=5����ôb2-b1=3��Ȼ���Ӧ��pick��ֵ��0.6
% ��ôret=2+3*0.6=3.8,����b1��b2֮��
% ��Ϊinput��x��5ά�ȣ�����output��һ��1*5��������ÿ��ֵ��Ӧxi�����ڹ涨��������֮��
