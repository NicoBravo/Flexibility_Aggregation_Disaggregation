function [Ainq,binq]=Building_Matrix(x)

    x = x';
    
    horizon=length(x(2:end))/4;
    A_building=x(1);
    B_building=1;
    [b1,b2,b3,b4]=Extract_from_vector(x);
    
    % constaint for u
    
    % u ≥ umin
    
    Ainq_1 = -eye(horizon);
    binq_1 = b1;

    % u ≤ umax

    Ainq_2 = eye(horizon);
    binq_2 = b2;
    
    % constaint for x
    F= matrixF(A_building,horizon);
    H = matrixH(A_building,B_building,horizon);
    
%     if (  ~isempty(xmin)  ) * (  ~isempty(xmax)  ) ==1
   
        % x ≥ xmin
        Ainq_3 = -H;
        binq_3 = b3;

        % x ≤ xmax
        Ainq_4 = H;
        binq_4 = b4;
    
%     else 
%         Ainq_3 = [];
%         binq_3 = [];
%         Ainq_4 = [];
%         binq_4 = [];
%     
%     end    
    
    % total
    Ainq=[Ainq_1;Ainq_2;Ainq_3;Ainq_4];
    binq=[binq_1;binq_2;binq_3;binq_4];

end




























