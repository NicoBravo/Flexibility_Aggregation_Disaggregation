function flag=Containment_Yalmip(A_agg,b_agg)
% 判断Uagg是否∈Um
% flag = 0 → not contain
% flag = 1 → contain

    global A_Um b_Um

    len_row=size(A_Um,1);
    len_colume=size(A_agg,1);

    L_y = sdpvar(len_row,len_colume,'full');
    Constraints = [L_y(:) >= 0, L_y*A_agg == A_Um, L_y*b_agg <= b_Um];
    Objective = norm(L_y,1);
    ops = sdpsettings('solver','mosek','verbose',0,'debug',1);
    % ops = sdpsettings('verbose',0,'debug',1);
    sol = optimize(Constraints,Objective,ops);
    % sol = optimize(Constraints,Objective);
    if sol.problem == 0  % 代表正常可解
        flag = 1;
    elseif sol.problem == 1
        flag = 0;
    end


end
