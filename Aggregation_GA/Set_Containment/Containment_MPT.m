function flag=Containment_MPT(A_agg,b_agg)
% �ж�Uagg�Ƿ��Um
% flag = 0 �� not contain
% flag = 1 �� contain

    global A_Um b_Um

    len_row=size(A_Um,1);
    len_colume=size(A_agg,1);

    Um=Polyhedron(A_Um,b_Um);
    Uagg=Polyhedron(A_agg,b_agg); 
    flag = (Uagg <= Um);


end
