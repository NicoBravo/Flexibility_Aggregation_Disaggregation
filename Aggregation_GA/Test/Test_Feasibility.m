function Flag=Test_Feasibility(lenchrom,bound,code,Containment_Type)
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% code       output: Ⱦɫ��ı���ֵ

Flag_Bound=Test_Bound(bound,code);

Flag_UXlimit=Test_UXlimit(code);

Flag_Containment=Test_Containment(code,Containment_Type);

Flag = Flag_Bound.*Flag_UXlimit.*Flag_Containment;

end



