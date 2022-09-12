function flag=Containment_MPT(A_agg,b_agg)
% ÅÐ¶ÏUaggÊÇ·ñ¡ÊUm
% flag = 0 ¡ú not contain
% flag = 1 ¡ú contain

    global A_Um b_Um

    len_row=size(A_Um,1);
    len_colume=size(A_agg,1);

    Um=Polyhedron(A_Um,b_Um);
    Uagg=Polyhedron(A_agg,b_agg); 
    flag = (Uagg <= Um);


end
