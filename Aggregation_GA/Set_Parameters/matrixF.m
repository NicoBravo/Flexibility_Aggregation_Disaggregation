function F = matrixF(A,N)
    nx = size(A,1);
    F = zeros(nx*N,nx);

    for j = 1:N
        F((nx*(j-1)+1):nx*j,:) = A^j;
    end
end



























