function Flag_Containment=Test_Containment(code,Containment_Type)
% code的每一行是否满足containment
% flag = 1 → contain
    [n,m]=size(code);
    Flag_Containment=ones(n,1);
    for i=1:n
        x=code(i,:);
        [A_agg,b_agg]=Building_Matrix(x);
        Flag_Containment(i) = Containment(Containment_Type,A_agg,b_agg);
    end
end
