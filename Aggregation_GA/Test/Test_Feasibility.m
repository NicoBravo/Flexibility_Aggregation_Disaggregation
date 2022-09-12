function Flag=Test_Feasibility(lenchrom,bound,code,Containment_Type)
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% code       output: 染色体的编码值

Flag_Bound=Test_Bound(bound,code);

Flag_UXlimit=Test_UXlimit(code);

Flag_Containment=Test_Containment(code,Containment_Type);

Flag = Flag_Bound.*Flag_UXlimit.*Flag_Containment;

end



