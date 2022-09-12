function flag=Containment_CVX(A_agg,b_agg)
% ÅÐ¶ÏUaggÊÇ·ñ¡ÊUm
% flag = 0 ¡ú not contain
% flag = 1 ¡ú contain

global A_Um b_Um

len_row=size(A_Um,1);
len_colume=size(A_agg,1);

%% Ê¹ÓÃcvx¼ì²âcontainment
cvx_begin
    variables L(len_row,len_colume) 
    minimize( norm(L,1) )
    % minimize could be saved, just to test existance
    subject to
        L >= 0;
        L*A_agg == A_Um;
        L*b_agg <= b_Um;
cvx_end

cvx_status = 'Solved';

if strcmp(cvx_status,'Solved')
    flag = 1;
elseif strcmp(cvx_status,'Infeasible')
    flag = 0;
end


end
