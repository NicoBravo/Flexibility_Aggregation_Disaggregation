function Flag_Bound=Test_Bound(bound,code)
% 检测是否越界
% 默认没问题就是1，有问题就是0

    [n,m]=size(code);
    Flag_Bound=ones(n,1);
    for i=1:n
        for j=1:m
            if code(i,j)<bound(j,1) || code(i,j)>bound(j,2)
                Flag_Bound(i)=0;
                break
            end
        end
    end

end