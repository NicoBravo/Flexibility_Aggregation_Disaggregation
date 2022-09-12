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


























