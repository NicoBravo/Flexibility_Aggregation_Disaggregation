function vol=Fitness(type,A_agg,b_agg)
    
    switch type
        case 'MPT'
            vol=Fitness_MPT(A_agg,b_agg);
        case 'VolEsti'
            vol=VolEsti_Matlab(A_agg,b_agg);
        case 'Ben'
            vol=Fitness_Ben(A_agg,b_agg);
    end
    
end