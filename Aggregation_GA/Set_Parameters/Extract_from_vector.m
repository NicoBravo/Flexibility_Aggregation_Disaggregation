function [b1,b2,b3,b4]=Extract_from_vector(x)
% get the part b1 b2 b3 b4 from vector x
    if ~iscolumn(x)
        x = x';
    end
        
    horizon=length(x(2:end))/4;
    b1 = x(1+0*horizon+1:1+1*horizon);
    b2 = x(1+1*horizon+1:1+2*horizon);
    b3 = x(1+2*horizon+1:1+3*horizon);
    b4 = x(1+3*horizon+1:1+4*horizon);

end

























