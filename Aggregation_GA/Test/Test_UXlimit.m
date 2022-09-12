function Flag_UXlimit=Test_UXlimit(code)
% 检测是否满足Umin ≤ Umax 和 Xmin ≤ Xmax
% 默认没问题就是1，有问题就是0

    [n,m]=size(code);
    Flag_UXlimit=ones(n,1);
    for i=1:n
        x=code(i,:);
        [b1,b2,b3,b4]=Extract_from_vector(x);
        horizon=length(b1);
        
        % test Umin ≤ Umax
        Test_U_vec = (  (b1+b2) >= zeros(horizon,1)  );
        % normally, b1+b2 should all be positive, and Test_U_vec all=1
        sig_U = ismember(0, Test_U_vec); % normally, sig_U = 0
        if sig_U == 1
            Flag_UXlimit(i)=0;
            break
        end
        
        % test Xmin ≤ Xmax
        Test_X_vec = (  (b3+b4) >= zeros(horizon,1)  );
        % normally, b3+b4 should all be positive, and Test_X_vec all=1
        sig_X = ismember(0, Test_X_vec); % normally, sig_X = 0
        if sig_X == 1
            Flag_UXlimit(i)=0;
            break
        end

    end

end