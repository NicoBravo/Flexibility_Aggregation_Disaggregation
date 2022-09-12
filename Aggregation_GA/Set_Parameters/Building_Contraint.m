function [Ainq,binq]=Building_Contraint(a,umin,umax,xmin,xmax,x0)

    horizon=length(umin);
    A_building=a;
    B_building=1;
    
    % constaint for u
    
    % u ≥ umin
    
    Ainq_1 = -eye(horizon);
    binq_1 = -umin;

    % u ≤ umax

    Ainq_2 = eye(horizon);
    binq_2 = umax;
    
    % constaint for x
    F= matrixF(A_building,horizon);
    H = matrixH(A_building,B_building,horizon);
    
    if (  ~isempty(xmin)  ) * (  ~isempty(xmax)  ) ==1
   
        % x ≥ xmin
        Ainq_3 = -H;
        binq_3 = -xmin+F*x0;

        % x ≤ xmax
        Ainq_4 = H;
        binq_4 = xmax-F*x0;
    
    else 
        Ainq_3 = [];
        binq_3 = [];
        Ainq_4 = [];
        binq_4 = [];
    
    end    
    
    % total
    Ainq=[Ainq_1;Ainq_2;Ainq_3;Ainq_4];
    binq=[binq_1;binq_2;binq_3;binq_4];

end


function F = matrixF(A,N)
    nx = size(A,1);
    F = zeros(nx*N,nx);

    for j = 1:N
        F((nx*(j-1)+1):nx*j,:) = A^j;
    end
end

function H = matrixH(A,B,N)
    nx = size(A,1); % number of State Variables
    ni= size (B,2); % number of inputs
    H = zeros(nx*N,ni*N);
    for j = 1:N
        for i = j:N
        H((i-1)*nx+1:nx*i,(j-1)*ni+1:j*ni) = A^(i-j)*B;
        end
    end
end


























