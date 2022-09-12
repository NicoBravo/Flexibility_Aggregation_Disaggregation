function flag=Containment(Containment_Type,A_agg,b_agg)
% ÅÐ¶ÏUaggÊÇ·ñ¡ÊUm
% flag = 0 ¡ú not contain
% flag = 1 ¡ú contain

    switch Containment_Type
        case 'CVX'
            flag = Containment_CVX(A_agg,b_agg);
        case 'Yalmip'
            flag = Containment_Yalmip(A_agg,b_agg);
        case 'MPT'
            flag = Containment_MPT(A_agg,b_agg);
    end


end
